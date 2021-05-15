Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4106381628
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 May 2021 07:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbhEOFb5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 May 2021 01:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbhEOFbz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 May 2021 01:31:55 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2DAC06174A
        for <linux-btrfs@vger.kernel.org>; Fri, 14 May 2021 22:30:42 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id e18so402933plh.8
        for <linux-btrfs@vger.kernel.org>; Fri, 14 May 2021 22:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fkv02/s+yYHPrpUYtpbYEsAacNcBrMN+wpev3GmK05c=;
        b=CUuiY4DTGu31b36dDxhXlXppRP+CtaMGh34UnUjer0RipHY0Dfmed8nilbkHsXM9UN
         mhayICkNuuG9iytYg22dMCtDM+4j/DCFxUMF8W/im/zM5WzWjREx6sReMeUmHev+DMSo
         uN3kaUWqAG/lRoYkI8H+LJ6xG36pj3Hb0eLldtVYTN9Nk+e59kh+c08o3SXiKcpKq3M0
         kyZULYaIBez1clP6gFLWqQYbOqCYOd0cvDL1pKUPQ2Q4J8TwD5Xu4V1+QN7nPZ56lUj2
         Jf567K5szfnjinfXkOw3r7vFDL6iut0AxBpldgp5ttIVgqETKyemrZwad1OZEyaUx33G
         lGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fkv02/s+yYHPrpUYtpbYEsAacNcBrMN+wpev3GmK05c=;
        b=tEd6X/5+I+GyDj8sRpppqk6UL2MDqOJvZpBzNRdqQM55C2NVJR3SJUOkcolDdE2u2a
         oj7959vqKU5aUFzc/X8Lu9/8sTroWnCSOVym+KtksStd4g/orcZ+X4WD1UBnOmEbbP+p
         nuhOrzJUxYHQcqAMybhI9GIRTKT9CfNTtlhFpB4PC8yb7fwA5QFqGBTADdGvwoupnOJw
         q0ae+RLRM3uTaoSuQHLYKrnMfp4nxN1tgBwAwMczlDpFk47Uz4q8OBA4zPBgl6+uTGeY
         HOR28wnMn3y4ceTCcwAFu1Od54JHPQBiutxM5WikLziQjStEBVgoh+7pc98E6XSTqHE3
         kTBQ==
X-Gm-Message-State: AOAM533L5xSxFvpMtOt+Wu12m1KD/QP8XIo4CTa+FNVhpdmY77exorHx
        0EJGS67lDI7DECQuuJyQy/Y=
X-Google-Smtp-Source: ABdhPJxPvK8gULzBu1JCZGsLpv1Ke0H7hpnjSpCQjpTpLhSN0N7BJE4NVKF92rGvkpzw6ldJMS/UEQ==
X-Received: by 2002:a17:902:7b8e:b029:ec:f35a:918e with SMTP id w14-20020a1709027b8eb02900ecf35a918emr49893692pll.77.1621056642273;
        Fri, 14 May 2021 22:30:42 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id a16sm5302779pfa.95.2021.05.14.22.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 22:30:41 -0700 (PDT)
Date:   Sat, 15 May 2021 05:30:34 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: subvolume: destroy associated qgroup when
 delete subvolume
Message-ID: <20210515053034.GA8193@realwakka>
References: <20210515023624.8065-1-realwakka@gmail.com>
 <7702abe4-f150-44c0-8328-f62d68f5a56c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7702abe4-f150-44c0-8328-f62d68f5a56c@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 15, 2021 at 10:42:15AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/5/15 上午10:36, Sidong Yang wrote:
> > This patch adds the options --delete-qgroup and --no-delete-qgroup. When
> > the option is enabled, delete subvolume command destroies associated
> > qgroup together. This patch make it as default option. Even though quota
> > is disabled, it enables quota temporary and restore it after.
> 

Thanks for reply!

> No, this is not a good idea at all.
> 
> First thing first, if quota is disabled, all qgroup info including the
> level 0 qgroups will also be deleted, thus no need to enable in the
> first place.
> 
> Secondly, there is already a patch in the past to delete level 0 qgroups
> in kernel space, which should be a much better solution.

Good, I think there is no need to make changes for userspace.

Thanks,
Sidong
> 
> I didn't remember when, but I'm pretty sure I did send out such patch in
> the past.
> 
> Maybe it's time to revive the patch now.
> 
> Thanks,
> Qu
> 
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> > 
> > I wrote a patch that adds command to delete associated qgroup when
> > delete subvolume together. It also works when quota disabled. How it
> > works is enable quota temporary and restore it. I don't know it's good
> > way. Is there any better way than this?
> > 
> >   cmds/subvolume.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 51 insertions(+)
> > 
> > diff --git a/cmds/subvolume.c b/cmds/subvolume.c
> > index 9bd17808..18c75083 100644
> > --- a/cmds/subvolume.c
> > +++ b/cmds/subvolume.c
> > @@ -239,6 +239,8 @@ static const char * const cmd_subvol_delete_usage[] = {
> >   	"-c|--commit-after      wait for transaction commit at the end of the operation",
> >   	"-C|--commit-each       wait for transaction commit after deleting each subvolume",
> >   	"-i|--subvolid          subvolume id of the to be removed subvolume",
> > +	"--delete-qgroup        delete associated qgroup together",
> > +	"--no-delete-qgroup     don't delete associated qgroup",
> >   	"-v|--verbose           deprecated, alias for global -v option",
> >   	HELPINFO_INSERT_GLOBALS,
> >   	HELPINFO_INSERT_VERBOSE,
> > @@ -266,14 +268,18 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
> >   	enum { COMMIT_AFTER = 1, COMMIT_EACH = 2 };
> >   	enum btrfs_util_error err;
> >   	uint64_t default_subvol_id = 0, target_subvol_id = 0;
> > +	bool delete_qgroup = false;
> > 
> >   	optind = 0;
> >   	while (1) {
> >   		int c;
> > +		enum { GETOPT_VAL_DEL_QGROUP = 256, GETOPT_VAL_NO_DEL_QGROUP };
> >   		static const struct option long_options[] = {
> >   			{"commit-after", no_argument, NULL, 'c'},
> >   			{"commit-each", no_argument, NULL, 'C'},
> >   			{"subvolid", required_argument, NULL, 'i'},
> > +			{"delete-qgroup", no_argument, NULL, GETOPT_VAL_DEL_QGROUP},
> > +			{"no-delete-qgroup", no_argument, NULL, GETOPT_VAL_NO_DEL_QGROUP},
> >   			{"verbose", no_argument, NULL, 'v'},
> >   			{NULL, 0, NULL, 0}
> >   		};
> > @@ -295,6 +301,12 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
> >   		case 'v':
> >   			bconf_be_verbose();
> >   			break;
> > +		case GETOPT_VAL_DEL_QGROUP:
> > +			delete_qgroup = true;
> > +			break;
> > +		case GETOPT_VAL_NO_DEL_QGROUP:
> > +			delete_qgroup = false;
> > +			break;
> >   		default:
> >   			usage_unknown_option(cmd, argv);
> >   		}
> > @@ -388,6 +400,44 @@ again:
> >   		goto out;
> >   	}
> > 
> > +	if (delete_qgroup) {
> > +		struct btrfs_ioctl_qgroup_create_args args;
> > +		memset(&args, 0, sizeof(args));
> > +		args.create = 0;
> > +		args.qgroupid = target_subvol_id;
> > +
> > +		if (ioctl(fd, BTRFS_IOC_QGROUP_CREATE, &args) < 0) {
> > +			if (errno == ENOTCONN) {
> > +				struct btrfs_ioctl_quota_ctl_args quota_ctl_args;
> > +				quota_ctl_args.cmd = BTRFS_QUOTA_CTL_ENABLE;
> > +				if (ioctl(fd, BTRFS_IOC_QUOTA_CTL, &quota_ctl_args) < 0) {
> > +					error("unable to enable quota: %s",
> > +						  strerror(errno));
> > +					goto out;
> > +				}
> > +
> > +				if (ioctl(fd, BTRFS_IOC_QGROUP_CREATE, &args) < 0) {
> > +					quota_ctl_args.cmd = BTRFS_QUOTA_CTL_DISABLE;
> > +					ioctl(fd, BTRFS_IOC_QUOTA_CTL, &args);
> > +					error("unable to destroy quota group: %s",
> > +						  strerror(errno));
> > +					goto out;
> > +				}
> > +
> > +				quota_ctl_args.cmd = BTRFS_QUOTA_CTL_DISABLE;
> > +				if (ioctl(fd, BTRFS_IOC_QUOTA_CTL, &args) < 0) {
> > +					error("unable to disable quota: %s",
> > +						  strerror(errno));
> > +					goto out;
> > +				}
> > +			} else {
> > +				error("unable to destroy quota group: %s",
> > +					  strerror(errno));
> > +				goto out;
> > +			}
> > +		}
> > +	}
> > +
> >   	pr_verbose(MUST_LOG, "Delete subvolume (%s): ",
> >   		commit_mode == COMMIT_EACH ||
> >   		(commit_mode == COMMIT_AFTER && cnt + 1 == argc) ?
> > @@ -412,6 +462,7 @@ again:
> >   		goto out;
> >   	}
> > 
> > +
> >   	if (commit_mode == COMMIT_EACH) {
> >   		res = wait_for_commit(fd);
> >   		if (res < 0) {
> > 
