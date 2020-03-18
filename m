Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFEED18A3EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Mar 2020 21:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgCRUom (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Mar 2020 16:44:42 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.87]:36646 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726647AbgCRUom (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Mar 2020 16:44:42 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id F035A1908691
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Mar 2020 15:44:40 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id EfYOj4RWV8vkBEfYOjvf4K; Wed, 18 Mar 2020 15:44:40 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=si61D0A4ID4RSCnZ2SRW5VrL3Wqy78APh1gG8KGLpR8=; b=fcBd+8HZM2I+q+NtsGnPrIdoAq
        8OCk0O2iwJdZwq8WSPo9je0XZ/xCJbk/oM5//SSQOyKkLSKMEIvlsMihq/HTcYQjiZdNCdfWUtqPn
        9UE2Kx03aHTESrAw4d3OZRtCAv6ts6GmQIZC8e7D++hA/XPnF4qvFOvI4uPHAFk8Wot8aeujgwVYN
        9GsdOD4CPgPo2Wa4BpT4AfBxEQQFFWxzyxvAr6v0Uevxng3JOjfp0cSjBOVp77Y5Yn6jL322Y8wnl
        iNSx9wpq0P8J3m4jpJq0RuMPnmO43YthLplFn4DKgaKGD5L7jIWNYFC4JGg2QAT1nxWs7L3G0eKue
        xbKdRozA==;
Received: from [191.249.66.103] (port=50770 helo=hephaestus)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jEfYO-001BAB-82; Wed, 18 Mar 2020 17:44:40 -0300
Date:   Wed, 18 Mar 2020 17:47:50 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH 2/2] btrfs-progs: replace: New argument to resize the fs
 after replace
Message-ID: <20200318204750.GA26752@hephaestus>
References: <20200307224516.16315-1-marcos@mpdesouza.com>
 <20200307224516.16315-3-marcos@mpdesouza.com>
 <045de5ab-e46e-3108-5f28-3f0a1c4e6902@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <045de5ab-e46e-3108-5f28-3f0a1c4e6902@gmx.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 191.249.66.103
X-Source-L: No
X-Exim-ID: 1jEfYO-001BAB-82
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus) [191.249.66.103]:50770
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 42
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 18, 2020 at 06:56:51PM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/3/8 上午6:45, Marcos Paulo de Souza wrote:
> > From: Marcos Paulo de Souza <mpdesouza@suse.com>
> > 
> > By using the -a flag on replace makes btrfs issue a resize ioctl after
> > the replace finishes. This argument is a shortcut for
> > 
> > btrfs replace start -f 3 /dev/sdf BTRFS/
> > btrfs fi resize 3:max BTRFS/
> > 
> > The -a stands for "automatically resize"
> > 
> > Fixes: #21
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> >  Documentation/btrfs-replace.asciidoc |  4 +++-
> >  cmds/replace.c                       | 19 +++++++++++++++++--
> >  2 files changed, 20 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/btrfs-replace.asciidoc b/Documentation/btrfs-replace.asciidoc
> > index b73bf1b3..e0b30066 100644
> > --- a/Documentation/btrfs-replace.asciidoc
> > +++ b/Documentation/btrfs-replace.asciidoc
> > @@ -18,7 +18,7 @@ SUBCOMMAND
> >  *cancel* <mount_point>::
> >  Cancel a running device replace operation.
> >  
> > -*start* [-Bfr] <srcdev>|<devid> <targetdev> <path>::
> > +*start* [-aBfr] <srcdev>|<devid> <targetdev> <path>::
> >  Replace device of a btrfs filesystem.
> >  +
> >  On a live filesystem, duplicate the data to the target device which
> > @@ -53,6 +53,8 @@ never allowed to be used as the <targetdev>.
> >  +
> >  -B::::
> >  no background replace.
> > ++a::::
> > +automatically resizes the filesystem if the <targetdev> is bigger than <srcdev>.
> 
> Resizes "to its max size".
> 
> >  
> >  *status* [-1] <mount_point>::
> >  Print status and progress information of a running device replace operation.
> > diff --git a/cmds/replace.c b/cmds/replace.c
> > index 2321aa15..48f470cd 100644
> > --- a/cmds/replace.c
> > +++ b/cmds/replace.c
> > @@ -91,7 +91,7 @@ static int dev_replace_handle_sigint(int fd)
> >  }
> >  
> >  static const char *const cmd_replace_start_usage[] = {
> > -	"btrfs replace start [-Bfr] <srcdev>|<devid> <targetdev> <mount_point>",
> > +	"btrfs replace start [-aBfr] <srcdev>|<devid> <targetdev> <mount_point>",
> >  	"Replace device of a btrfs filesystem.",
> >  	"On a live filesystem, duplicate the data to the target device which",
> >  	"is currently stored on the source device. If the source device is not",
> > @@ -104,6 +104,8 @@ static const char *const cmd_replace_start_usage[] = {
> >  	"from the system, you have to use the <devid> parameter format.",
> >  	"The <targetdev> needs to be same size or larger than the <srcdev>.",
> >  	"",
> > +	"-a     automatically resize the filesystem if the <targetdev> is bigger",
> > +	"       than <srcdev>",
> 
> Same here, resize to its max size.
> 
> >  	"-r     only read from <srcdev> if no other zero-defect mirror exists",
> >  	"       (enable this if your drive has lots of read errors, the access",
> >  	"       would be very slow)",
> > @@ -129,6 +131,7 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
> >  	char *path;
> >  	char *srcdev;
> >  	char *dstdev = NULL;
> > +	bool auto_resize = false;
> >  	int avoid_reading_from_srcdev = 0;
> >  	int force_using_targetdev = 0;
> >  	u64 dstdev_block_count;
> > @@ -138,8 +141,11 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
> >  	u64 dstdev_size;
> >  
> >  	optind = 0;
> > -	while ((c = getopt(argc, argv, "Brf")) != -1) {
> > +	while ((c = getopt(argc, argv, "aBrf")) != -1) {
> >  		switch (c) {
> > +		case 'a':
> > +			auto_resize = true;
> > +			break;
> >  		case 'B':
> >  			do_not_background = 1;
> >  			break;
> > @@ -309,6 +315,15 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
> >  			goto leave_with_error;
> >  		}
> >  	}
> > +
> > +	if (ret == 0 && auto_resize && dstdev_size > srcdev_size) {
> > +		char amount[BTRFS_PATH_NAME_MAX + 1];
> > +		snprintf(amount, BTRFS_PATH_NAME_MAX, "%s:max", srcdev);
> > +
> > +		if (resize_filesystem(amount, path))
> > +			goto leave_with_error;
> > +	}
> > +
> 
> I'm pretty happy since it's all done in user space.
> 
> But this is a different error, here we succeeded in replace, but only
> failed in resize (which should be pretty rare to hit though).
> 
> We should provide some better error message for it other than just error
> out.

Function resize_filesystem already checks for errors, and it even print's a
resize message before calling the resize ioctl. Or do you mean another message
specifying that "replace finished, but resize failed" along the messages already
being provided by resize_filesystem function?

Thanks,
  Marcos

> 
> Thanks,
> Qu
> 
> >  	close_file_or_dir(fdmnt, dirstream);
> >  	return 0;
> >  
> > 
> 



