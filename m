Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A55C4BC8EA
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Feb 2022 15:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241009AbiBSOkx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Feb 2022 09:40:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiBSOku (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Feb 2022 09:40:50 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0A28596F
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Feb 2022 06:40:31 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id z2so722733plg.8
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Feb 2022 06:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AQkbRKJFpVrZ8y1Kf912BYGPQ0niFhBHzVnBYNXEJBk=;
        b=J/h/hytJkXVP0Sjts8AxWybuSlxkpyO0VCYRbuJwIk//73fiqZ/plpVgdUW7kHQEMZ
         +36XH1PQvOs1aJ9S9vgI76M2sOcmz+dzocsJ5qRW764dOwyzZCdBUXSblUE6ScWX/A3W
         dzs/jf+18B2YDkymnGc1pglWD+0DzMEH3i7Hjj4/VSUyAgkCU3OaNOvGJfoxpjBVz3F7
         HBG181Ea7DsOvkeQlpdkDePKCs7lxeeXthDnvw62IiR1x7hLz+77IhGMmNQct1eIMpvF
         iGByKdQ404H/snTWbAWoIXi0rdss+qVt3Z93U4EUl/1vAi//V3LV2co0ZQi6SkyjyOFU
         JQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AQkbRKJFpVrZ8y1Kf912BYGPQ0niFhBHzVnBYNXEJBk=;
        b=uY8sOGZtM/RTOwIY2f+JOiQmK6R9jXBY2WM/ZSvbz+PbCJmCIbHOrcaGV1/BR5OSKv
         9qhNQyzwaRGWtnormGWngBli4+WHaAA7/FpC3jsXG2XECQLSI6EvtLJLmWaOusUunSph
         i/HNUVK3NA0A3+GAEBZKstY+ZpfTdfPXR4d+Rx2xQ4kRKNhKDca/9ZDl5Mj9rPHCZL6W
         Pdvfl+v73L2eyc2PYNjwMLq7k+YICbbEzmwCqPxl/wA9cy0nQ31PtDYqy+Njvyziy4C2
         nNcvEgSgK77IPtkYOwuuxOnHSkAZegumBbaFI89G5BtXTGzl1JVaWhxUlKiVd1vnltEH
         qqmg==
X-Gm-Message-State: AOAM530xG5jij3hF2jmLdIJvLdHFKvvmmhylQiyYV6fg7KMU1oIyhAt/
        +SsMILMYI64/NG0t9NlQxuRgJrPzgI8=
X-Google-Smtp-Source: ABdhPJxXDqtmksRYhq7DKzWqnGuxOKe5iHPnHNWF4CQ74XUVQ137sCmsFNkAS6SeblzBZ7T1DipU0Q==
X-Received: by 2002:a17:90a:5302:b0:1b9:ba0a:27e5 with SMTP id x2-20020a17090a530200b001b9ba0a27e5mr17197280pjh.91.1645281631106;
        Sat, 19 Feb 2022 06:40:31 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id y27sm13276840pgc.92.2022.02.19.06.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 06:40:30 -0800 (PST)
Date:   Sat, 19 Feb 2022 14:40:23 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     kreijack@inwind.it
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: cmds: subvolume: add -p option on creating
 subvol
Message-ID: <20220219144023.GA51314@realwakka>
References: <20220219090123.51185-1-realwakka@gmail.com>
 <ff095079-d5b9-6664-3ba1-37cd83c6a4ed@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff095079-d5b9-6664-3ba1-37cd83c6a4ed@libero.it>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 19, 2022 at 03:11:36PM +0100, Goffredo Baroncelli wrote:

Hi, Thanks for review.

> On 19/02/2022 10.01, Sidong Yang wrote:
> > This patch resolves github issue #429. This patch adds an option that
> > create parent directories when it creates subvolumes on nonexisting
> > parents. This option tokenizes dstdir and checks each paths whether
> > it's existing directory and make directory for creating subvolume.
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> >   cmds/subvolume.c | 31 ++++++++++++++++++++++++++++++-
> >   1 file changed, 30 insertions(+), 1 deletion(-)
> > 
> > diff --git a/cmds/subvolume.c b/cmds/subvolume.c
> > index fbf56566..1070c74a 100644
> > --- a/cmds/subvolume.c
> > +++ b/cmds/subvolume.c
> > @@ -88,6 +88,7 @@ static const char * const cmd_subvol_create_usage[] = {
> >   	"",
> >   	"-i <qgroupid>  add the newly created subvolume to a qgroup. This",
> >   	"               option can be given multiple times.",
> > +	"-p             make any missing parent directories for each argument",
> 
> you should update the man page too

Thanks I'll do it for next version.
> 
> >   	HELPINFO_INSERT_GLOBALS,
> >   	HELPINFO_INSERT_QUIET,
> >   	NULL
> 
> [...]
> 
> > +	if (create_parents) {
> > +		char p[PATH_MAX];
> > +		char dstdir_real[PATH_MAX];
> > +		char *token;
> > +
> > +		realpath(dstdir, dstdir_real);
> 
> realpath(3) behaves strangely when the path doesn't exist: if exists only /tmp, realpath("/tmp/1/2/3/4/5") returns "/tmp/1" discarding 2/3/4....
> In fact my gcc warns:
> 
> $ make
>     [CC]     cmds/subvolume.o
> cmds/subvolume.c: In function ‘cmd_subvol_create’:
> cmds/subvolume.c:180:17: warning: ignoring return value of ‘realpath’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
>   180 |                 realpath(dstdir, dstdir_real);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> because realpath(3) returns an error if the path doesn't exist.
> 
> This causes:
> 
> # only /tmp/ exists
> btrfs sub cre -p /tmp/1/2/3/4/5/6
> ERROR: cannot access '/tmp/1/2/3/4/5': No such file or directory

Yes, It's completely wrong code. I'll correct it. For now, I think I
need to check whether the path is absolute or relative for checking
dstdir[0] == '/'.
> 
> 
> > +		token = strtok(dstdir_real, "/");
> > +		while(token) {
> > +			strcat(p, "/");
> 
> where is initialized p ?

I missed it. Thanks.
> 
> Unfortunately it works and the gcc doesn't warn, but I think only because in the stack there are zeros where p is allocated; but this is not guarantee.
> 
> > +			strcat(p, token);
> > +			res = path_is_dir(p);
> > +			if (res == -ENOENT) {
> > +				if (mkdir(p, 0755)) {
> > +					error("failed to make dir: %s", p);
> > +					goto out;
> > +				}
> > +			} else if (res <= 0) {
> > +				error("failed to check dir: %s", p);				
> > +				goto out;
> > +			}
> > +			token = strtok(NULL, "/");
> > +		}
> > +	}
> > +
> >   	fddst = btrfs_open_dir(dstdir, &dirstream, 1);
> >   	if (fddst < 0)
> >   		goto out;
> 
> 
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
