Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC694BCB7A
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Feb 2022 02:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbiBTB2b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Feb 2022 20:28:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiBTB23 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Feb 2022 20:28:29 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3969C527ED
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Feb 2022 17:28:09 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id q11-20020a17090a304b00b001b94d25eaecso11940529pjl.4
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Feb 2022 17:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z9kBKm/qWhb1fstnyDc+sMjKKgIYA5Xxzkeb6AW9iTk=;
        b=XXosJwUGEqL54pB9yj7UCsU4sSgz9YopoJHKqXdNENpODW6MZNKOAF/5UdQeaskiyc
         YPT98BnzACrcCguTqH1NOwZPLHwd/HYTF5h/rcsaCspPYwl45RfEDbQFcgfALQe9FfVO
         engnL/VTGWA6FV8U9U0PR3wJ0zdOScSEzum3zZnTmVR+pHcTG2Yc4+sPMZGyyIZrcE7I
         yNbSEbtDxjTlkzj944sZn84MI4u5gfO7x8QpZtDlQTYOlAeqUJ3D/iZU0Fi6x7/hbCd7
         qdTjwL5adpfMopoiS0mMVuAsCEaHKvxr2GclsircUmTtAIxPmrEvAPsG1+2tEArKY8oj
         57Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z9kBKm/qWhb1fstnyDc+sMjKKgIYA5Xxzkeb6AW9iTk=;
        b=cFNKA/JIQDOIwYzmaa6VD69TUkLFKX0z8aTiV83FBFYIP2iFJop2RrIVL6sR6qL6N+
         5n6v4aZyY+IdRVqagR/AG1WRYxZ3WKX/N61Jab9k5kO57a30z658S93dkEjaVQgcC3rm
         +3hopCjRZhT7kYFfVsRmFPa0KusVfW9X3i9BH4J48qgIsh4eJb0KuGRtoCM+LgaZ0yr3
         0cjbjEmJeipI4CvfTw9WY074LGIaZV8+DgXSMAoBJh986CZTb882Ap9A5qQwUDwc2i4Y
         uje+YJxfKh1oMqnn0fj5aMe6jNTGdyjFmBt8ZrtsrofGcoMuInhpqClfX0mO2fNV1h1J
         VWmQ==
X-Gm-Message-State: AOAM531udTE+t9MqGxmMZCvyMwpa4V1wwYoNPbSnIs+9Z0kJjpOXvtLc
        cncGlh0b+j7frj1b4Tq/JDg=
X-Google-Smtp-Source: ABdhPJzZvj4m2w4K9nM/RiHN6PYuNAGE1yMkU39uQs/vu0xBVizvzpTxhlP8z6Xc4NFeqULSz9XSwA==
X-Received: by 2002:a17:90a:4308:b0:1b8:bed5:c747 with SMTP id q8-20020a17090a430800b001b8bed5c747mr15062903pjg.0.1645320488626;
        Sat, 19 Feb 2022 17:28:08 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id a29sm14272440pgl.24.2022.02.19.17.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 17:28:08 -0800 (PST)
Date:   Sun, 20 Feb 2022 01:28:03 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: cmds: subvolume: add -p option on
 creating subvol
Message-ID: <20220220012803.GB51314@realwakka>
References: <20220219151143.52091-1-realwakka@gmail.com>
 <65d64775-565e-c257-d65f-7ab9da22f1c9@cobb.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65d64775-565e-c257-d65f-7ab9da22f1c9@cobb.uk.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 19, 2022 at 04:38:03PM +0000, Graham Cobb wrote:

Hi, Cobb.
Thanks for review.
> On 19/02/2022 15:11, Sidong Yang wrote:
> > This patch resolves github issue #429. This patch adds an option that
> > create parent directories when it creates subvolumes on nonexisting
> > parents. This option tokenizes dstdir and checks each paths whether
> > it's existing directory and make directory for creating subvolume.
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> > v2: fixed the case using realpath() that path nonexists, added
> > description on docs.
> > ---
> >  Documentation/btrfs-subvolume.rst |  3 +++
> >  cmds/subvolume.c                  | 34 ++++++++++++++++++++++++++++++-
> >  2 files changed, 36 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/btrfs-subvolume.rst b/Documentation/btrfs-subvolume.rst
> > index 4591d4bb..89809822 100644
> > --- a/Documentation/btrfs-subvolume.rst
> > +++ b/Documentation/btrfs-subvolume.rst
> > @@ -61,6 +61,9 @@ create [-i <qgroupid>] [<dest>/]<name>
> >                  Add the newly created subvolume to a qgroup. This option can be given multiple
> >                  times.
> >  
> > +        -p
> > +                Make any missing parent directories for each argument.
> > +
> >  delete [options] [<subvolume> [<subvolume>...]], delete -i|--subvolid <subvolid> <path>
> >          Delete the subvolume(s) from the filesystem.
> >  
> > diff --git a/cmds/subvolume.c b/cmds/subvolume.c
> > index fbf56566..7df0d2ec 100644
> > --- a/cmds/subvolume.c
> > +++ b/cmds/subvolume.c
> > @@ -88,6 +88,7 @@ static const char * const cmd_subvol_create_usage[] = {
> >  	"",
> >  	"-i <qgroupid>  add the newly created subvolume to a qgroup. This",
> >  	"               option can be given multiple times.",
> > +	"-p             make any missing parent directories for each argument.",
> >  	HELPINFO_INSERT_GLOBALS,
> >  	HELPINFO_INSERT_QUIET,
> >  	NULL
> > @@ -105,10 +106,11 @@ static int cmd_subvol_create(const struct cmd_struct *cmd,
> >  	char	*dst;
> >  	struct btrfs_qgroup_inherit *inherit = NULL;
> >  	DIR	*dirstream = NULL;
> > +	bool create_parents = false;
> >  
> >  	optind = 0;
> >  	while (1) {
> > -		int c = getopt(argc, argv, "c:i:");
> > +		int c = getopt(argc, argv, "c:i:p");
> >  		if (c < 0)
> >  			break;
> >  
> > @@ -127,6 +129,9 @@ static int cmd_subvol_create(const struct cmd_struct *cmd,
> >  				goto out;
> >  			}
> >  			break;
> > +		case 'p':
> > +			create_parents = true;
> > +			break;
> >  		default:
> >  			usage_unknown_option(cmd, argv);
> >  		}
> > @@ -167,6 +172,33 @@ static int cmd_subvol_create(const struct cmd_struct *cmd,
> >  		goto out;
> >  	}
> >  
> > +	if (create_parents) {
> > +		char p[PATH_MAX] = {0};
> 
> I'm not a fan of single letter variable names, especially for
> substantive objects such as large character arrays (as opposed to a
> pointer keeping track of a position in some other object). But maybe
> that is just me.
> 
I think it would be better that adding longopt "--parents" and it seems
that requestor wants it.

> > +		char dstdir_dup[PATH_MAX];
> > +		char *token;
> > +
> > +		strcpy(dstdir_dup, dstdir);
> 
> Has dstdir already been checked its length is PATH_MAX-1 or less?
> Wouldn't it be safer to at least use strncpy plus overwriting the final
> byte with zero?
> 
Agree, It's not guaranteed that strlen(dstdir) is less than PATH_MAX.
strncpy() is a safer way than just strcpy().

> > +		if (dstdir_dup[0] == '/')
> > +			strcat(p, "/");
> > +
> > +		token = strtok(dstdir_dup, "/");
> > +		while(token) {
> > +			strcat(p, token);
> > +			res = path_is_dir(p);
> > +			if (res == -ENOENT) {
> > +				if (mkdir(p, 0755)) {
> 
> Why 0755? Personally I make use of groups and run with umask 0002. Why
> not just use 0777? I realise this is unlikely to be significantly
> important but I dislike programs overriding the user's choice of umask.
> I assume the requestor's intention was that the behaviour should be the
> same as "mkdir -p".

Thanks, I didn't know that mode parameter in mkdir() works in (mode &
~umask & 0777). Now I realize that using 0777 is correct way to follow
user's choice. I'll fix this for next version.

Thanks,
Sidong
> 
> Graham
> 
> > +					error("failed to make dir: %s", p);
> > +					goto out;
> > +				}
> > +			} else if (res <= 0) {
> > +				error("failed to check dir: %s", p);				
> > +				goto out;
> > +			}
> > +			strcat(p, "/");
> > +			token = strtok(NULL, "/");
> > +		}
> > +	}
> > +
> >  	fddst = btrfs_open_dir(dstdir, &dirstream, 1);
> >  	if (fddst < 0)
> >  		goto out;
> 
