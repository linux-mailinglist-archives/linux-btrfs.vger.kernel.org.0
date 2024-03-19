Return-Path: <linux-btrfs+bounces-3441-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30260880467
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 19:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A953EB23809
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 18:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37152D60F;
	Tue, 19 Mar 2024 18:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="04wjhNNa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C302D051
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871817; cv=none; b=aIEECN1btq4JrvPydfKJKXAKv5Pkdzu9bweXBfq//yRM8LE/JYzS0TTfMRUuEVqorOYAZZbq17p9SGDXpxVqsMeUyl/w6S/DOSwKJwtgv51Y1967ZKHOjZhHZfNb1e5Nf2N0C6nY4rTSpYdgfz7hWouHACRYFD394XBUg7kj/Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871817; c=relaxed/simple;
	bh=4wjNaGIUMJrbvs94fasY3uHoJ3IULpCcCgFwha/TJG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuIJ3piKXRiseFZh7l9JAbP0dvHRxsgJgUedxKlhGNKw1U8pyhNVTxXXjr60+ISQbulqo+Uzt0oTC9S813NFrct1sNEDmf8fi8HRSyKveRh44+DZ1ZqFRLLcLiJuG08SxoRMECdTLGNVqplFpNdKlQOdSum4e54QPlg8QGBzCDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=04wjhNNa; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-69629b4ae2bso12062336d6.3
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 11:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710871814; x=1711476614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kPFf/6zGxirOywGeiTp7/1pHxmjcFv4yr7HdtqBLPGI=;
        b=04wjhNNag/7zav4JiwhP51+Um94z+4kgovawl8KScSmlTcNXg8v8AEIpXkIK3OaO2D
         RhI8NE2U4fyxU90lHeowjqxxYXiDVyAK9bhGXFi62dNRdoZXHPLutf5IDGV0BsYyh04y
         5QZLDJOoU8Ts5JLkLBDgmMpNNVQTjlkJe2ESBtHdoHW690dMMOAM6TqEbxWCTumLF8PN
         ra4JEryJ6TX//B9JOAOYEcuUPzg5V1e6f9Mo4iqN4r2X+hcDZLDlkT1e2RK2fbPht2Tn
         MvzGOcvqKhIRm++nJUqmIzGngKZzl17mFzJGl3er+5+kNQud38ulx5FpJRPrL9hvBCNl
         JxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710871814; x=1711476614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPFf/6zGxirOywGeiTp7/1pHxmjcFv4yr7HdtqBLPGI=;
        b=ued4Yss2/H6lB/nTESLmGRAAV9Nc9Ex0DyXFDGCLo9UaoTmuyHX8N29HCl3+ByADKY
         yKtrlUEpYMX+8/mePdJbOXspOlgvwqunukpw3t/zFaxKtvxBQu4ujfCWyLLFk6tkCNI2
         8CGwTkvbjNL0w5elNKm1sl7DEqFDJZssgki9/zJzGlJNNCI87yujosE6ER5gi3jodHrQ
         zceacirwRxXeV0XiOtELDpywyT59mKqrem5QrRx6O8pKH9Dzf7EvMekcQbJ+FHw3Ilp5
         aDKGpPP0yDO8jbTniiX1k/nwJiv00lCh1qVFac6FM6rH6a9Wn+ugJKSS3qbtRhDtErKs
         Lkrw==
X-Gm-Message-State: AOJu0YwfSAlSCS4hX0OoAjl4L79KoALghlcqOahZFuSk4nwAtoOG8MvK
	+VxP+qwblGE+/s0X10yVyghIWA4vVkRYaiRfnTzLjDNMbCHh9XvLx2cz08dqK7imlMUn2gRAcdw
	d
X-Google-Smtp-Source: AGHT+IHZ7enLtzoHc7d0XBtopQOA3sfefUlZv1pPX9xYwXDSSQY/lSHHY9eh7df9inO8meNEhCaUzw==
X-Received: by 2002:a0c:dc14:0:b0:696:22ae:eb67 with SMTP id s20-20020a0cdc14000000b0069622aeeb67mr3058708qvk.33.1710871814540;
        Tue, 19 Mar 2024 11:10:14 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id gi7-20020a056214248700b0069612003bacsm3141248qvb.53.2024.03.19.11.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 11:10:14 -0700 (PDT)
Date: Tue, 19 Mar 2024 14:10:13 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 21/29] btrfs: quick_update_accounting rename err to ret2
Message-ID: <20240319181013.GI2982591@perftesting>
References: <cover.1710857863.git.anand.jain@oracle.com>
 <1f4bdab06e7acee3118c0278d7f16a352146ccf5.1710857863.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f4bdab06e7acee3118c0278d7f16a352146ccf5.1710857863.git.anand.jain@oracle.com>

On Tue, Mar 19, 2024 at 08:25:29PM +0530, Anand Jain wrote:
> In quick_update_accounting err is used as 2nd return value, rename it to
> ret2.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/qgroup.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 5f90f0605b12..23a08910fa67 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1541,16 +1541,16 @@ static int quick_update_accounting(struct btrfs_fs_info *fs_info,
>  {
>  	struct btrfs_qgroup *qgroup;
>  	int ret = 1;
> -	int err = 0;
> +	int ret2 = 0;
>  
>  	qgroup = find_qgroup_rb(fs_info, src);
>  	if (!qgroup)
>  		goto out;
>  	if (qgroup->excl == qgroup->rfer) {
>  		ret = 0;
> -		err = __qgroup_excl_accounting(fs_info, dst, qgroup, sign);
> -		if (err < 0) {
> -			ret = err;
> +		ret2 = __qgroup_excl_accounting(fs_info, dst, qgroup, sign);
> +		if (ret2 < 0) {
> +			ret = ret2;
>  			goto out;
>  		}

This can be reworked to

ret = __qgroup_excl_accounting(fs_info, dst, qgroup, sign);
if (ret < 0)
	goto out;
ret = 0;

Thanks,

Josef

