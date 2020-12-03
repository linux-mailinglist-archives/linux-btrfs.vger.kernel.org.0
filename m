Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23B12CCE3A
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 06:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgLCFEX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 00:04:23 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:20197 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgLCFEX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 00:04:23 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4CmkJD0zqWzKw;
        Thu,  3 Dec 2020 06:03:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1606971821; bh=f1Gb4SxxHN59H8iTXv8TYBBgv5t2nfeo2X3YmFgqJD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YaOmlBl+agVMGrEhHyHN43s0EAVir9GS1+Wbt79yyOdWZUIShpjbV5gdth7ujxMF2
         LSffLJcu0U4U70+5sYBJw8pBWz7CNfN5732TbuuRaN6H1/8fmqgUplaYHdTehFragR
         9i5S5laWX2M6JdZ+n5jWUsUUVMpbga9Ckv9R13QZHIghDsSwWPLyz/fh4P4jergT3z
         sAyk4ncmYVg6AboZAOF++YIMpeWs3PY553ogwZUWkjf5yd0bP6Ds3v6NqIEeC0rXzw
         UoUGFLvULO2bEDhEdW6B5nm46ACSZFeIFDP6sUC6I51iCs8rVdxxCFaFX6ek3vOvC6
         OSUKxG/KTv5XQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Thu, 3 Dec 2020 06:03:35 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Nick Terrell <terrelln@fb.com>
Cc:     Nick Terrell <nickrterrell@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "squashfs-devel@lists.sourceforge.net" 
        <squashfs-devel@lists.sourceforge.net>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v6 1/3] lib: zstd: Add kernel-specific API
Message-ID: <20201203050335.GA1532@qmqm.qmqm.pl>
References: <20201202203242.1187898-1-nickrterrell@gmail.com>
 <20201202203242.1187898-2-nickrterrell@gmail.com>
 <20201203011606.GA20621@qmqm.qmqm.pl>
 <297D9C8B-5F4D-4E3B-A5FD-DA292D8BA12A@fb.com>
 <20201203031429.GA13095@qmqm.qmqm.pl>
 <85E09AFA-F1ED-41CB-B712-7FA75374478F@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85E09AFA-F1ED-41CB-B712-7FA75374478F@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 03, 2020 at 03:59:21AM +0000, Nick Terrell wrote:
> On Dec 2, 2020, at 7:14 PM, Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:
> > On Thu, Dec 03, 2020 at 01:42:03AM +0000, Nick Terrell wrote:
> >> On Dec 2, 2020, at 5:16 PM, Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:
> >>> On Wed, Dec 02, 2020 at 12:32:40PM -0800, Nick Terrell wrote:
> >>>> From: Nick Terrell <terrelln@fb.com>
> >>>> 
> >>>> This patch:
> >>>> - Moves `include/linux/zstd.h` -> `lib/zstd/zstd.h`
> >>>> - Adds a new API in `include/linux/zstd.h` that is functionally
> >>>> equivalent to the in-use subset of the current API. Functions are
> >>>> renamed to avoid symbol collisions with zstd, to make it clear it is
> >>>> not the upstream zstd API, and to follow the kernel style guide.
> >>>> - Updates all callers to use the new API.
> >>>> 
> >>>> There are no functional changes in this patch. Since there are no
> >>>> functional change, I felt it was okay to update all the callers in a
> >>>> single patch, since once the API is approved, the callers are
> >>>> mechanically changed.
> >>> [...]
> >>>> --- a/lib/decompress_unzstd.c
> >>>> +++ b/lib/decompress_unzstd.c
> >>> [...]
> >>>> static int INIT handle_zstd_error(size_t ret, void (*error)(char *x))
> >>>> {
> >>>> -	const int err = ZSTD_getErrorCode(ret);
> >>>> -
> >>>> -	if (!ZSTD_isError(ret))
> >>>> +	if (!zstd_is_error(ret))
> >>>> 		return 0;
> >>>> 
> >>>> -	switch (err) {
> >>>> -	case ZSTD_error_memory_allocation:
> >>>> -		error("ZSTD decompressor ran out of memory");
> >>>> -		break;
> >>>> -	case ZSTD_error_prefix_unknown:
> >>>> -		error("Input is not in the ZSTD format (wrong magic bytes)");
> >>>> -		break;
> >>>> -	case ZSTD_error_dstSize_tooSmall:
> >>>> -	case ZSTD_error_corruption_detected:
> >>>> -	case ZSTD_error_checksum_wrong:
> >>>> -		error("ZSTD-compressed data is corrupt");
> >>>> -		break;
> >>>> -	default:
> >>>> -		error("ZSTD-compressed data is probably corrupt");
> >>>> -		break;
> >>>> -	}
> >>>> +	error("ZSTD decompression failed");
> >>>> 	return -1;
> >>>> }
> >>> 
> >>> This looses diagnostics specificity - is this intended? At least the
> >>> out-of-memory condition seems useful to distinguish.
> >> 
> >> Good point. The zstd API no longer exposes the error code enum,
> >> but it does expose zstd_get_error_name() which can be used here.
> >> I was thinking that the string needed to be static for some reason, but
> >> that is not the case. I will make that change.
> >> 
> >>>> +size_t zstd_compress_stream(zstd_cstream *cstream,
> >>>> +	struct zstd_out_buffer *output, struct zstd_in_buffer *input)
> >>>> +{
> >>>> +	ZSTD_outBuffer o;
> >>>> +	ZSTD_inBuffer i;
> >>>> +	size_t ret;
> >>>> +
> >>>> +	memcpy(&o, output, sizeof(o));
> >>>> +	memcpy(&i, input, sizeof(i));
> >>>> +	ret = ZSTD_compressStream(cstream, &o, &i);
> >>>> +	memcpy(output, &o, sizeof(o));
> >>>> +	memcpy(input, &i, sizeof(i));
> >>>> +	return ret;
> >>>> +}
> >>> 
> >>> Is all this copying necessary? How is it different from type-punning by
> >>> direct pointer cast?
> >> 
> >> If breaking strict aliasing and type-punning by pointer casing is okay, then
> >> we can do that here. These memcpys will be negligible for performance, but
> >> type-punning would be more succinct if allowed.
> > 
> > Ah, this might break LTO builds due to strict aliasing violation.
> > So I would suggest to just #define the ZSTD names to kernel ones
> > for the library code.  Unless there is a cleaner solution...
> 
> I don’t want to do that because I want in the 3rd series of the patchset I update
> to zstd-1.4.6. And I’m using zstd-1.4.6 as-is in upstream. This allows us to keep
> the kernel version up to date, since the patch to update to a new version can be
> generated automatically (and manually tested), so it doesn’t fall years behind
> upstream again.
> 
> The alternative would be to make upstream zstd’s header public and
> #define zstd_in_buffer ZSTD_inBuffer. But that would make zstd’s header
> public, which would somewhat defeat the purpose of having a kernel wrapper.

I thought the problem was API style spill-over from the library to other parts
of the kernel.  A header-only wrapper can stop this.  I'm not sure symbol
visibility (namespace pollution) was a concern.

Best Regards
Michał Mirosław
