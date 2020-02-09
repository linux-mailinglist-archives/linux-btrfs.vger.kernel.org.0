Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA632156B2F
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Feb 2020 16:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgBIPsr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Feb 2020 10:48:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38003 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbgBIPsr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 9 Feb 2020 10:48:47 -0500
Received: by mail-pl1-f196.google.com with SMTP id t6so1786572plj.5;
        Sun, 09 Feb 2020 07:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eBHJ23t3af84Xj83/gZ6pVZL31LMLCGqZ9QDtHGTAEU=;
        b=mTY2+34YfZ04qqZMsVRTF68kQTTnzYLf5UFLo9vR3Q5PTFTigJdSSE59PjD9+7W4FH
         YdQGVi28cDjugjuPBJLJA/RKBMzT5P4J09oL33k191DRHVuPkvCc9999e8/e8j8Urtr+
         Bs3fJylu7a1xdyRGJixtoJMB+oUwcAZ7HmLs8kxe0B9S5zIwnvWloRAECYuDM4xGWjhv
         3rTGW6eDlQ1N4lVOS4w1+wbg51WKovUYM+TL+fkCJingIJK5QRHKBf5/CUOEeKkZnvno
         k9ilyO1rPIrIi0v6pqBTvPqpc/5GeP/gKSr+U2w/SvYp/RKFsSnnZqqsCA/G99muGwJ5
         hRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eBHJ23t3af84Xj83/gZ6pVZL31LMLCGqZ9QDtHGTAEU=;
        b=Eh/360MSyygGt01Jqc0/A2r4yeAtn1BjkTqbjNjv2Wxl7H+OmTtbK3QyC38LNgEkBA
         gt4H8qQyEQeS9ODdfq7SyVS0fhdViEVRA8oGz0+35+geju42yY8VrgZ+FhIoJzydvNiG
         k0NMz2wrKWkt+rSRIDTOpxGDxrAwAMDnxK1T374OF0LGnkVZTPafUBv+qXB2CvHmilMM
         q8bRdoMqSe7JkEIYmeDSvyI1LWpmAvYrAJzQVybF9w+74dgTj01PnCUEUAztDbq86BS3
         XKzmCvt3oj0ZW93R0A2+m98RBFNBocT0GemR+DzKEYnyAifQ4Q+nD4C59KPEkIxHadR5
         dT9g==
X-Gm-Message-State: APjAAAWTam7gnPN+3aixZ9/qr94AuGv5HFdmz/ti0ymaZ7LaHyedCsQj
        Yf1sFdEV4FnpmicqaNHFKpA=
X-Google-Smtp-Source: APXvYqwC75O54SYhA7g0m+jFr1/9k8lQkShevesp2EbbeuIbPlCZ1Q23Kdb8rBmw4A3wJS0K385EtQ==
X-Received: by 2002:a17:902:d705:: with SMTP id w5mr8804042ply.68.1581263326562;
        Sun, 09 Feb 2020 07:48:46 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id n15sm9565679pfq.168.2020.02.09.07.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 07:48:46 -0800 (PST)
Date:   Sun, 9 Feb 2020 23:48:40 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] fstests: Always dump dmesg for failed test cases
Message-ID: <20200209154840.GF2697@desktop>
References: <20200120070938.30247-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120070938.30247-1-wqu@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 20, 2020 at 03:09:37PM +0800, Qu Wenruo wrote:
> When hard-to-hit bugs happened, we really want every piece of info to
> help us debugging.
> 
> Although we already have KEEP_DMESG config, not everyone is utilizing
> it, thus when hard-to-hit bugs happened, one could only set it and retry
> until next hit.
> 
> This patch will change the behavior by always dumping the dmesg for
> failed tests, so that developers can always get extra info from any
> failure.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  check | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/check b/check
> index 2e148e5776e5..e580b2249f06 100755
> --- a/check
> +++ b/check
> @@ -840,6 +840,9 @@ for section in $HOST_OPTIONS_SECTIONS; do
>  
>  	# make sure we record the status of the last test we ran.
>  	if $err ; then
> +		if [ ! -f $seqres.dmesg ]; then
> +			_dmesg_since_test_start >$seqres.dmesg
> +		fi

So this only saves the dmesg of the last test?

And I don't think this is necessary, even if it saves the dmesgs of all
failed tests, this behavior change requires some more diskspace and may
fulfill / more easily.

I think if one knows he/she's debugging a hard-to-hit bug, set
KEEP_DMESG. Or again, make "save dmesg of every failed test" a tunable
behavior.

Thanks,
Eryu

>  		bad="$bad $seqnum"
>  		n_bad=`expr $n_bad + 1`
>  		tc_status="fail"
> -- 
> 2.24.1
> 
