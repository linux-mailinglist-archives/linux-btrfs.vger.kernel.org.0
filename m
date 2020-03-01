Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7F9B174D86
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Mar 2020 14:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgCANhx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Mar 2020 08:37:53 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43826 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCANhx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Mar 2020 08:37:53 -0500
Received: by mail-pf1-f196.google.com with SMTP id s1so4191540pfh.10;
        Sun, 01 Mar 2020 05:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OUHM7fhwAGtY91X9vebs++ZljysVhV37CX1gkp2YxuU=;
        b=mH+QalsWuH8JFgHA12ugky0o5pGk2h0bLhtsM53MxIk6GMUVNUak6DLQkNLbCxP5lP
         K4gofHd5oTW4p7DVo9JNMUNwiEg3njDJ7UJhmaSRgOpp3der0qpRQSqJWlMhf62eK2YQ
         gypba9cYOMMG1Ad8wCYqxbMRqu9HH2ixNjmB1mLGCTOq3kOOg7rcypRBpH8RGKjmAu4i
         AMe5jRs+feluwfsIG7jeOOchpKV79m5CMcJL8cQxrfhD1El0mLM8mEb+7IMfZpLH1jo/
         2+XOQYIwtDta6IeKgps6Kkl5ovz3C51s/55pW22sVn8QjR2bAG+bb73S0cbyzQI7igSR
         vJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OUHM7fhwAGtY91X9vebs++ZljysVhV37CX1gkp2YxuU=;
        b=dRBWxJq0MJ9zaAkxwEEszIgcjN2iYo1ACn9VT8tCJxkvdUD7NVFsgbtzH/nSza8jQU
         /24fvaV1NmFAaYt74PgjDHSTyeMcdHFILNUCmG4kkCTPRdmQ3OfpdzG+zN1542LxZBbc
         FyU/mfWa1ugA6SubE5ZALiqChf1O72goYOEbuzFNoMEbc4L1G/B1dMKzyrhgN4Q8DjuR
         FXZ0IsEL5dkHxa5JUU+lyyW9pwlW3aJM5CTnETgQXPzVBZppf7OlGqjWZ0Es4yFmWNv/
         oki8UEfm5IlUOSe4syrznmN2tXMNbN4ZQ44yDuiHIjoPgTdNyX3edfaNz/SMQksicKVq
         uS7w==
X-Gm-Message-State: APjAAAWSWXbsic4NLJ1cV25vxzu/uTLc1PwyPFD/RaM6Tort6aaUut26
        slvMHiDNxIQDK3DXTfvcPGHMC5td
X-Google-Smtp-Source: APXvYqxt3LTax8ESzadtpv5NyIPAldLgykoox6RPRg1zioD/h+ixuk6O1f2yNBNcNfLKYaZ+mWcmgw==
X-Received: by 2002:a63:cf41:: with SMTP id b1mr14168721pgj.53.1583069872120;
        Sun, 01 Mar 2020 05:37:52 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id mr7sm5080302pjb.12.2020.03.01.05.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 05:37:50 -0800 (PST)
Date:   Sun, 1 Mar 2020 21:36:02 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     dsterba@suse.com, nborisov@suse.com, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [ fstests PATCHv3 1/2] common: btrfs: Improve
 _require_btrfs_command
Message-ID: <20200301133600.GJ3840@desktop>
References: <20200224031341.27740-1-marcos@mpdesouza.com>
 <20200224031341.27740-2-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224031341.27740-2-marcos@mpdesouza.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 24, 2020 at 12:13:40AM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Now _require_btrfs_command can also check for subfuntion options, like
> "subvolume delete --subvolid".
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Ah, this patch has already been applied in previous updates. Please see

2f9b4039253d common/btrfs: Improve _require_btrfs_command

Thanks,
Eryu

> ---
> Changes from v2:
> * Added Reviewed-by from Nikolay to patch 0001
> 
> Changes from v1:
> * New patch expanding the funtionality of _require_btrfs_command, which now
>   check for argument of subcommands
> 
>  common/btrfs | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index 19ac7cc4..ae3142b6 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -12,12 +12,14 @@ _btrfs_get_subvolid()
>  
>  # _require_btrfs_command <command> [<subcommand>|<option>]
>  # We check for btrfs and (optionally) features of the btrfs command
> -# It can both subfunction like "inspect-internal dump-tree" and
> -# options like "check --qgroup-report"
> +# This function support both subfunction like "inspect-internal dump-tree" and
> +# options like "check --qgroup-report", and also subfunction options like
> +# "subvolume delete --subvolid"
>  _require_btrfs_command()
>  {
>  	local cmd=$1
>  	local param=$2
> +	local param_arg=$3
>  	local safe_param
>  
>  	_require_command "$BTRFS_UTIL_PROG" btrfs
> @@ -39,6 +41,13 @@ _require_btrfs_command()
>  
>  	$BTRFS_UTIL_PROG $cmd $param --help &> /dev/null
>  	[ $? -eq 0 ] || _notrun "$BTRFS_UTIL_PROG too old (must support $cmd $param)"
> +
> +	test -z "$param_arg" && return
> +
> +	# replace leading "-"s for grep
> +	safe_param=$(echo $param_arg | sed 's/^-*//')
> +	$BTRFS_UTIL_PROG $cmd $param --help | grep -wq $safe_param || \
> +		_notrun "$BTRFS_UTIL_PROG too old (must support $cmd $param $param_arg)"
>  }
>  
>  # Require extra check on btrfs qgroup numbers
> -- 
> 2.25.0
> 
