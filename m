Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829202CCD26
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 04:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgLCDPQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 22:15:16 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:23742 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgLCDPQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 22:15:16 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4CmgtH6LsqzDf;
        Thu,  3 Dec 2020 04:14:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1606965273; bh=ZdAOG3NcuHGK7lFYYvnqJKsMgeqVqed0k+AuMpqBsVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GbJ6klnUee1HbJVtw4KbzKPz4NHSRXuqMt8jfsssGDrrXWb+AvlXHq3ixQPcK78Nk
         9fSBwuY0GonAcufYJEOaZksH29dY7d0okUcxXy9ZRT4Rb3BRcgkUdO2PblQoR9bnrz
         SSwooLfwoxjfsFCd/eN2JFpaAD48NXJk4NUDXxDYkJ9T01VyuVtPmbsVHlcLeKXorW
         ATi1zQlQaXpUBMVLahgIG6Es64dQNVKOxMDLa1c+vkauJAqEQLYECYl6xFD6YjzpzS
         yAxqcO2/Bzlh19IG28c8VBQLOgpolEx5P17ixPpGzJlyXhFNzZ6mGIPzqIvaxs80UO
         NKWwFyrmBzQIg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Thu, 3 Dec 2020 04:14:29 +0100
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
Message-ID: <20201203031429.GA13095@qmqm.qmqm.pl>
References: <20201202203242.1187898-1-nickrterrell@gmail.com>
 <20201202203242.1187898-2-nickrterrell@gmail.com>
 <20201203011606.GA20621@qmqm.qmqm.pl>
 <297D9C8B-5F4D-4E3B-A5FD-DA292D8BA12A@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <297D9C8B-5F4D-4E3B-A5FD-DA292D8BA12A@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 03, 2020 at 01:42:03AM +0000, Nick Terrell wrote:
> 
> 
> > On Dec 2, 2020, at 5:16 PM, Micha³ Miros³aw <mirq-linux@rere.qmqm.pl> wrote:
> > 
> > On Wed, Dec 02, 2020 at 12:32:40PM -0800, Nick Terrell wrote:
> >> From: Nick Terrell <terrelln@fb.com>
> >> 
> >> This patch:
> >> - Moves `include/linux/zstd.h` -> `lib/zstd/zstd.h`
> >> - Adds a new API in `include/linux/zstd.h` that is functionally
> >>  equivalent to the in-use subset of the current API. Functions are
> >>  renamed to avoid symbol collisions with zstd, to make it clear it is
> >>  not the upstream zstd API, and to follow the kernel style guide.
> >> - Updates all callers to use the new API.
> >> 
> >> There are no functional changes in this patch. Since there are no
> >> functional change, I felt it was okay to update all the callers in a
> >> single patch, since once the API is approved, the callers are
> >> mechanically changed.
> > [...]
> >> --- a/lib/decompress_unzstd.c
> >> +++ b/lib/decompress_unzstd.c
> > [...]
> >> static int INIT handle_zstd_error(size_t ret, void (*error)(char *x))
> >> {
> >> -	const int err = ZSTD_getErrorCode(ret);
> >> -
> >> -	if (!ZSTD_isError(ret))
> >> +	if (!zstd_is_error(ret))
> >> 		return 0;
> >> 
> >> -	switch (err) {
> >> -	case ZSTD_error_memory_allocation:
> >> -		error("ZSTD decompressor ran out of memory");
> >> -		break;
> >> -	case ZSTD_error_prefix_unknown:
> >> -		error("Input is not in the ZSTD format (wrong magic bytes)");
> >> -		break;
> >> -	case ZSTD_error_dstSize_tooSmall:
> >> -	case ZSTD_error_corruption_detected:
> >> -	case ZSTD_error_checksum_wrong:
> >> -		error("ZSTD-compressed data is corrupt");
> >> -		break;
> >> -	default:
> >> -		error("ZSTD-compressed data is probably corrupt");
> >> -		break;
> >> -	}
> >> +	error("ZSTD decompression failed");
> >> 	return -1;
> >> }
> > 
> > This looses diagnostics specificity - is this intended? At least the
> > out-of-memory condition seems useful to distinguish.
> 
> Good point. The zstd API no longer exposes the error code enum,
> but it does expose zstd_get_error_name() which can be used here.
> I was thinking that the string needed to be static for some reason, but
> that is not the case. I will make that change.
> 
> >> +size_t zstd_compress_stream(zstd_cstream *cstream,
> >> +	struct zstd_out_buffer *output, struct zstd_in_buffer *input)
> >> +{
> >> +	ZSTD_outBuffer o;
> >> +	ZSTD_inBuffer i;
> >> +	size_t ret;
> >> +
> >> +	memcpy(&o, output, sizeof(o));
> >> +	memcpy(&i, input, sizeof(i));
> >> +	ret = ZSTD_compressStream(cstream, &o, &i);
> >> +	memcpy(output, &o, sizeof(o));
> >> +	memcpy(input, &i, sizeof(i));
> >> +	return ret;
> >> +}
> > 
> > Is all this copying necessary? How is it different from type-punning by
> > direct pointer cast?
> 
> If breaking strict aliasing and type-punning by pointer casing is okay, then
> we can do that here. These memcpys will be negligible for performance, but
> type-punning would be more succinct if allowed.

Ah, this might break LTO builds due to strict aliasing violation.
So I would suggest to just #define the ZSTD names to kernel ones
for the library code.  Unless there is a cleaner solution...

Best Regards
Micha³ Miros³aw
