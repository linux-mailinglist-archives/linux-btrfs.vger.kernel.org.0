Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFE5410E297
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Dec 2019 17:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfLAQ0I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Dec 2019 11:26:08 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35631 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfLAQ0I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Dec 2019 11:26:08 -0500
Received: by mail-pf1-f194.google.com with SMTP id b19so411558pfo.2;
        Sun, 01 Dec 2019 08:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=64YKTokt6OTcg1BKFO0o7GlWDAgyNr2wQ4lM5JJVsMQ=;
        b=oS8/un/YvqOJw289xfyx8KH/+fHEtFY7l2iXb7c4CCFbyRZhrkqUiYvCHw3JanXeSv
         o0XCZX06voPUetHAj9J5NDMTK64xFJn/YF0sVx0K7nnc2r3dI4XGIZQLn0vVjOdDIXBa
         Dv3MWgxQfAc5RvMLxxIw9/Hz64FtResAjBwhqvFWTyf1j7i6RFpnLIsc+aSoKUJcPeSt
         ZRYaov88ZcXOpZGMPf2cJTqbJ42Ouxj79uhEU0/vOUmTjgdehOkEIN7xi3BTMj7eLVmO
         UmKEjaKDzVgOHePTv9xIpa5EcxCczCGm4GCtCKhZ+D2+Ipn6CfXsIbpv/TKMRtTJVGLb
         x5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=64YKTokt6OTcg1BKFO0o7GlWDAgyNr2wQ4lM5JJVsMQ=;
        b=TmXhJ5/9biNQJgzi6CETW0z9ywlb8qRi9I1UTwla6crG3KnjRZwgoJ3Qw3+4uN56G3
         638OFOPNqXSTQORcQX+dtPhddHEC4Rkpdl/FAo9xQtQATfhy+tENmYSsgGRfl0hBt4fI
         Hey5KmDLhmxIc3Ah6DIRdnXJ+Me8UPFSLjV+Tj6eC+PT1a2IhrzeGf6sup/XQqC6+n2r
         lpd1Dg+aeG+zwNo/Ama3yX/FMSmjsIQTAK4m9/e31U8HHRpd1Q6l9XNSZ2R+knx+M/Xn
         Ppc4EaH1i1n/uN9A8CJBlOAYVK9uEFB3hBtrUfFqEg7VUvRGWuZpa2AI0bNA9T6uZz+T
         qfeA==
X-Gm-Message-State: APjAAAW21N7G2UVl/5+xH6YLXZZI+vozR925rfduVbZcEvKnaxDj/bz2
        FhAGWVYCA0Cl5XmgkC7kGzQ=
X-Google-Smtp-Source: APXvYqyLG6PHin2TUKr2Sfi3rFCfwUs8yyi4HlkcUTzgkoxBCJmir0F9Am/jsv6Zd12RB4sUeFPsgw==
X-Received: by 2002:aa7:9826:: with SMTP id q6mr24347023pfl.89.1575217567942;
        Sun, 01 Dec 2019 08:26:07 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id x4sm4370078pfx.68.2019.12.01.08.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2019 08:26:07 -0800 (PST)
Date:   Mon, 2 Dec 2019 00:26:02 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: common: Allow user to keep $seqres.dmesg for
 all tests
Message-ID: <20191201162559.GK8664@desktop>
References: <20191129045743.47105-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129045743.47105-1-wqu@suse.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 29, 2019 at 12:57:43PM +0800, Qu Wenruo wrote:
> Currently fstests will remove $seqres.dmesg if nothing wrong happened.
> It saves some space, but sometimes it may not provide good enough
> history for developers to check.
> E.g. some unexpected dmesg from fs, but not serious enough to be caught
> by current filter.
> 
> So instead of deleting the ordinary $seqres.dmesg, provide a new config:
> KEEP_DMESG, to allow user to choose whether to keep the dmesg.
> 
> The default value for it is 0, which keeps the existing behavior by
> deleting ordinary dmesg.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  common/config | 4 ++++
>  common/rc     | 4 +++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/common/config b/common/config
> index 1b75777f..b409f32c 100644
> --- a/common/config
> +++ b/common/config
> @@ -22,6 +22,9 @@
>  # RMT_IRIXTAPE_DEV- the IRIX remote tape device for the xfsdump tests
>  # RMT_TAPE_USER -   remote user for tape device
>  # SELINUX_MOUNT_OPTIONS - Options to use when SELinux is enabled.
> +# KEEP_DMESG -      whether to keep all dmesg for each test case.
> +#                   1: keep all dmesg
> +#                   0: only keep dmesg with error/warning (default)
>  #
>  # - These can be added to $HOST_CONFIG_DIR (witch default to ./config)
>  #   below or a separate local configuration file can be used (using
> @@ -757,6 +760,7 @@ if [ -z "$CONFIG_INCLUDED" ]; then
>  	[ -z "$TEST_FS_MOUNT_OPTS" ] && _test_mount_opts
>  	[ -z "$MKFS_OPTIONS" ] && _mkfs_opts
>  	[ -z "$FSCK_OPTIONS" ] && _fsck_opts
> +	[ -z "$KEEP_DMESG" ] && export KEEP_DMESG=0

I changed this to a "yes"/"no" config, to match USE_KMEMLEAK, and
updated README as well.

Thanks,
Eryu

>  else
>  	# We get here for the non multi section case, on every test that sources
>  	# common/rc after re-sourcing the HOST_OPTIONS config file.
> diff --git a/common/rc b/common/rc
> index e5535279..a1386f61 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3634,7 +3634,9 @@ _check_dmesg()
>  		_dump_err "_check_dmesg: something found in dmesg (see $seqres.dmesg)"
>  		return 1
>  	else
> -		rm -f $seqres.dmesg
> +		if [ "$KEEP_DMESG" != 1 ]; then
> +			rm -f $seqres.dmesg
> +		fi
>  		return 0
>  	fi
>  }
> -- 
> 2.23.0
> 
