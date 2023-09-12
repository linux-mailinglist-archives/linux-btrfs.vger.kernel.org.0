Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996FA79D12B
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 14:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbjILMfT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 08:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbjILMfS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 08:35:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37F4910D5
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 05:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694522072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eBu8QFGGHrniD5fjvhovYgFP6bR6XUKKyXBiNreekfs=;
        b=JPwsWPbmaFo0VGGRZx2hmsLXwLfAOVtz55Z5/2gM4fnTYxgP7rcsznIeC5AeUmhQ+s6BLJ
        Ov5Y+gioxxOmrHuG2ZXBPdvNWNcMVI+5deCdBrjNm2sP0KyxE7qgzwfYCeQOdKLDJOO0SQ
        hY/C/cbjW677jwpxe9c6OMPcBxXOOJU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-eLgweBVhMxSE41kBpKQV3g-1; Tue, 12 Sep 2023 08:34:29 -0400
X-MC-Unique: eLgweBVhMxSE41kBpKQV3g-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-273f8487f53so4228085a91.1
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 05:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694522068; x=1695126868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBu8QFGGHrniD5fjvhovYgFP6bR6XUKKyXBiNreekfs=;
        b=vpNDPO69F6NarH1hDr4X821Zk31v/E6NthsK4V9HM13K2F2fQrjGTuBTWXSrfS02Qn
         tfYMyvJT1NoNWBuziwyNSIftmpTLnQ++/7JtQRi6eRqWBPbBl7E2iPrNNlP4AGJ19xA1
         TWuRaaasHRueQqCpyjrZLp7wtryTd7feynUJGJwdUruJgo8wvtdNNLEZ47mCaGihlW2r
         13YKVWeTsm8PV/PYl06a3blg24day8w2BcdrXgEBSJopwI9iVgoJXfmAulxg5/eDQ/F4
         S02Zoj1f6yTnUOecf8zx02eTT9ZV1fwP5dL5WAk+JQKBm1FiQxzL2vWSjopL4JR/weGm
         grLw==
X-Gm-Message-State: AOJu0Yx2XRqWb97i5MXOVGEiNSH7PmHa3Eca4Suq9YF8v3Kua71NrKgy
        FVcvt/P934JEY4fE+CR9hCNj0volZXlkiVTYc4OUjgccnGKX9qa0N+J+lEXYZ6JG5YFypIQEaoa
        s8UYpLT5u+PycheiweUWfgOy3nERugedhfw==
X-Received: by 2002:a17:90a:c58e:b0:268:ca76:64a with SMTP id l14-20020a17090ac58e00b00268ca76064amr9974716pjt.49.1694522067940;
        Tue, 12 Sep 2023 05:34:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGviPz0Iq3LT0P0x565RoZ7xF05LEfSe0Pcnp73e1gSCRYxbAYywh8un9FwH6hhLpmZS/N+tQ==
X-Received: by 2002:a17:90a:c58e:b0:268:ca76:64a with SMTP id l14-20020a17090ac58e00b00268ca76064amr9974704pjt.49.1694522067619;
        Tue, 12 Sep 2023 05:34:27 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090322c400b001bb1f0605b2sm8341066plg.214.2023.09.12.05.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 05:34:27 -0700 (PDT)
Date:   Tue, 12 Sep 2023 20:34:24 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/185 update for single device pseudo
 device-scan
Message-ID: <20230912123424.cy2bnpu3zbmbzxcy@zlang-mailbox>
References: <7558eed09a89d25fbd8083d45078cfe2e9601f45.1694017375.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7558eed09a89d25fbd8083d45078cfe2e9601f45.1694017375.git.anand.jain@oracle.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 07, 2023 at 12:24:43AM +0800, Anand Jain wrote:
> As we are obliterating the need for the device scan for the single device,
> which will return success if the basic superblock verification passes,
> even for the duplicate device of the mounted filesystem, drop the check
> for the return code in this testcase and continue to verify if the device
> path of the mounted filesystem remains unaltered after the scan.
> 
> Also, if the test fails, it leaves the local non-standard mount point
> remained mounted, leading to further test cases failing. Call unmount
> in _cleanup().
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

Make sense to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/185 | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/185 b/tests/btrfs/185
> index ba0200617e69..c7b8d2d46951 100755
> --- a/tests/btrfs/185
> +++ b/tests/btrfs/185
> @@ -15,6 +15,7 @@ mnt=$TEST_DIR/$seq.mnt
>  # Override the default cleanup function.
>  _cleanup()
>  {
> +	$UMOUNT_PROG $mnt > /dev/null 2>&1
>  	rm -rf $mnt > /dev/null 2>&1
>  	cd /
>  	rm -f $tmp.*
> @@ -51,9 +52,9 @@ for sb_bytenr in 65536 67108864; do
>  	echo ..:$? >> $seqres.full
>  done
>  
> -# Original device is mounted, scan of its clone should fail
> +# Original device is mounted, scan of its clone must not alter the
> +# filesystem device path
>  $BTRFS_UTIL_PROG device scan $device_2 >> $seqres.full 2>&1
> -[[ $? != 1 ]] && _fail "cloned device scan should fail"
>  
>  [[ $(findmnt $mnt | grep -v TARGET | $AWK_PROG '{print $2}') != $device_1 ]] && \
>  						_fail "mounted device changed"
> -- 
> 2.39.3
> 

