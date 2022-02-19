Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A825D4BC8CF
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Feb 2022 15:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242369AbiBSONB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Feb 2022 09:13:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238683AbiBSOM7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Feb 2022 09:12:59 -0500
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 19 Feb 2022 06:12:40 PST
Received: from libero.it (smtp-33.italiaonline.it [213.209.10.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56969434B8
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Feb 2022 06:12:40 -0800 (PST)
Received: from [192.168.1.27] ([78.12.10.146])
        by smtp-33.iol.local with ESMTPA
        id LQSWnNiCdABfqLQSXn4RY4; Sat, 19 Feb 2022 15:11:37 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1645279897; bh=eqU/XpDZ0v14g7S0gciWqQ0nxlWeNvKM1zguML3xpIM=;
        h=From;
        b=Cl6BiPc64FFYIFZ01m3mAzFbyr81qBti3Y8Q42ux2MYvY/VP7XlfbaWoyQhdOsL8V
         sPizl0m22ACc6J5VRtafR15nd7ORQvAa+Bh4WaRVOS6MOykhddJinF3vb2sNy1Aspb
         eUxh+/2YYGu4cEcvnNzQxf9p3lWKbU1m+v7xHCgBRXF1XjGh7NX+Zm1+ARrkKVlnLk
         VU2SqO/gyKe8c5o4HcsaJTxRC9s6c5x+7Pvo5bLgR1ypDoQruONNMBoPmVBrGKm0VL
         GYdNLRabI/GAvHXmfPmK/HmY1dUWsxIPtSs5zm2oTUKgzRKPr0dYpJd5tmFQn9OAxR
         lIV2EAeKdK6tw==
X-CNFS-Analysis: v=2.4 cv=X9+XlEfe c=1 sm=1 tr=0 ts=6210fa99 cx=a_exe
 a=2C5VI3o5eQqsNyEplIs8Sg==:117 a=2C5VI3o5eQqsNyEplIs8Sg==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=gI2hIfxYkgs3H6JFAToA:9 a=QEXdDO2ut3YA:10
Message-ID: <ff095079-d5b9-6664-3ba1-37cd83c6a4ed@libero.it>
Date:   Sat, 19 Feb 2022 15:11:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH] btrfs-progs: cmds: subvolume: add -p option on creating
 subvol
Content-Language: en-US
To:     Sidong Yang <realwakka@gmail.com>, linux-btrfs@vger.kernel.org
References: <20220219090123.51185-1-realwakka@gmail.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <20220219090123.51185-1-realwakka@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFuR6QSc8xVTdpOZfBgqEIyhJOheWNj6stVvyiZeVQSMX0LMSRETE+Ux/2kP0rpcm8mJp5IgxFBA3lniyGcEBKyETIz+7iPYTvpgN/2rpvm+rp7sBAza
 CQvuxuWMLUTS3534Qoa6JxCYuUnLA7c/eLQFVOxfVnCKWpGtfW3OyGXKl7C9piCHbf1zTPyei0O9NaCF+jEGlthA1iSdGoUvqpOEiQ2wcnRbxINRBi56rK7x
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/02/2022 10.01, Sidong Yang wrote:
> This patch resolves github issue #429. This patch adds an option that
> create parent directories when it creates subvolumes on nonexisting
> parents. This option tokenizes dstdir and checks each paths whether
> it's existing directory and make directory for creating subvolume.
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>   cmds/subvolume.c | 31 ++++++++++++++++++++++++++++++-
>   1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/cmds/subvolume.c b/cmds/subvolume.c
> index fbf56566..1070c74a 100644
> --- a/cmds/subvolume.c
> +++ b/cmds/subvolume.c
> @@ -88,6 +88,7 @@ static const char * const cmd_subvol_create_usage[] = {
>   	"",
>   	"-i <qgroupid>  add the newly created subvolume to a qgroup. This",
>   	"               option can be given multiple times.",
> +	"-p             make any missing parent directories for each argument",

you should update the man page too

>   	HELPINFO_INSERT_GLOBALS,
>   	HELPINFO_INSERT_QUIET,
>   	NULL

[...]

> +	if (create_parents) {
> +		char p[PATH_MAX];
> +		char dstdir_real[PATH_MAX];
> +		char *token;
> +
> +		realpath(dstdir, dstdir_real);

realpath(3) behaves strangely when the path doesn't exist: if exists only /tmp, realpath("/tmp/1/2/3/4/5") returns "/tmp/1" discarding 2/3/4....
In fact my gcc warns:

$ make
     [CC]     cmds/subvolume.o
cmds/subvolume.c: In function ‘cmd_subvol_create’:
cmds/subvolume.c:180:17: warning: ignoring return value of ‘realpath’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
   180 |                 realpath(dstdir, dstdir_real);
       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

because realpath(3) returns an error if the path doesn't exist.

This causes:

# only /tmp/ exists
btrfs sub cre -p /tmp/1/2/3/4/5/6
ERROR: cannot access '/tmp/1/2/3/4/5': No such file or directory


> +		token = strtok(dstdir_real, "/");
> +		while(token) {
> +			strcat(p, "/");

where is initialized p ?

Unfortunately it works and the gcc doesn't warn, but I think only because in the stack there are zeros where p is allocated; but this is not guarantee.

> +			strcat(p, token);
> +			res = path_is_dir(p);
> +			if (res == -ENOENT) {
> +				if (mkdir(p, 0755)) {
> +					error("failed to make dir: %s", p);
> +					goto out;
> +				}
> +			} else if (res <= 0) {
> +				error("failed to check dir: %s", p);				
> +				goto out;
> +			}
> +			token = strtok(NULL, "/");
> +		}
> +	}
> +
>   	fddst = btrfs_open_dir(dstdir, &dirstream, 1);
>   	if (fddst < 0)
>   		goto out;


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
