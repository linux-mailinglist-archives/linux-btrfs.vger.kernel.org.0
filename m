Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78E72CCB82
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 02:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbgLCBQv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 20:16:51 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:14765 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgLCBQv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 20:16:51 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4CmdFh0f48zDf;
        Thu,  3 Dec 2020 02:16:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1606958169; bh=6oH15t1Df77ZzG2EVYajQgZvMvBqFmQvQbWlZwQ2QEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SB1xzSoxRoViOvvVeCEfofLQUmg5XpUMvkEJnMhZgf4r5+49NISCcc68BpcHlcelp
         vNYiHf3Y6pH9y2kgG7CWVFcbafVXxYka/WdyrF0KPL5Hvh5EhPE4vDVnBYWQ3gRoX8
         ztYX1Suc2WQy4SYjMo6rZCiD2t1qqX3t4HkyXGYXL9AipWeYZm9B4FPZDuskD4j7MS
         ayG7+2YnPhqL8qlmrUe2wpRqI5pMaDMoU5rWiO90pfbg+wyvzGLDAFf7lfU7Rn2Ml5
         BU67UaFjNVJGrLp02M/bcgw7yq7F2AcsD/5mZfdpWtcSPr9z531bqis+g9Of2npGuf
         2JgTSxT7Emreg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Thu, 3 Dec 2020 02:16:06 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Nick Terrell <nickrterrell@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v6 1/3] lib: zstd: Add kernel-specific API
Message-ID: <20201203011606.GA20621@qmqm.qmqm.pl>
References: <20201202203242.1187898-1-nickrterrell@gmail.com>
 <20201202203242.1187898-2-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201202203242.1187898-2-nickrterrell@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 02, 2020 at 12:32:40PM -0800, Nick Terrell wrote:
> From: Nick Terrell <terrelln@fb.com>
> 
> This patch:
> - Moves `include/linux/zstd.h` -> `lib/zstd/zstd.h`
> - Adds a new API in `include/linux/zstd.h` that is functionally
>   equivalent to the in-use subset of the current API. Functions are
>   renamed to avoid symbol collisions with zstd, to make it clear it is
>   not the upstream zstd API, and to follow the kernel style guide.
> - Updates all callers to use the new API.
> 
> There are no functional changes in this patch. Since there are no
> functional change, I felt it was okay to update all the callers in a
> single patch, since once the API is approved, the callers are
> mechanically changed.
[...]
> --- a/lib/decompress_unzstd.c
> +++ b/lib/decompress_unzstd.c
[...]
>  static int INIT handle_zstd_error(size_t ret, void (*error)(char *x))
>  {
> -	const int err = ZSTD_getErrorCode(ret);
> -
> -	if (!ZSTD_isError(ret))
> +	if (!zstd_is_error(ret))
>  		return 0;
>  
> -	switch (err) {
> -	case ZSTD_error_memory_allocation:
> -		error("ZSTD decompressor ran out of memory");
> -		break;
> -	case ZSTD_error_prefix_unknown:
> -		error("Input is not in the ZSTD format (wrong magic bytes)");
> -		break;
> -	case ZSTD_error_dstSize_tooSmall:
> -	case ZSTD_error_corruption_detected:
> -	case ZSTD_error_checksum_wrong:
> -		error("ZSTD-compressed data is corrupt");
> -		break;
> -	default:
> -		error("ZSTD-compressed data is probably corrupt");
> -		break;
> -	}
> +	error("ZSTD decompression failed");
>  	return -1;
>  }

This looses diagnostics specificity - is this intended? At least the
out-of-memory condition seems useful to distinguish.

> +size_t zstd_compress_stream(zstd_cstream *cstream,
> +	struct zstd_out_buffer *output, struct zstd_in_buffer *input)
> +{
> +	ZSTD_outBuffer o;
> +	ZSTD_inBuffer i;
> +	size_t ret;
> +
> +	memcpy(&o, output, sizeof(o));
> +	memcpy(&i, input, sizeof(i));
> +	ret = ZSTD_compressStream(cstream, &o, &i);
> +	memcpy(output, &o, sizeof(o));
> +	memcpy(input, &i, sizeof(i));
> +	return ret;
> +}

Is all this copying necessary? How is it different from type-punning by
direct pointer cast?

Best Regards
Micha³ Miros³aw
