Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AE46B40A5
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 14:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjCJNmQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 08:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCJNmP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 08:42:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582AF10EAB7
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 05:42:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED57CB822B0
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 13:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF547C433EF
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 13:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678455730;
        bh=T7nEwGVAryCXgajI45FM+cVOWVNEjSDsGu20t1l1A6I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hbgHNxAv+lG8X2Qi0oddNdtYaNNBq8oOi3g7CosJ4/PL5wpwBHEySkAi2CqnFIprd
         JMczkj2AcdRv3GHNTYlmHT248T4Eh/OBXQq+HwKJUVa1X28H+SPgPdfpniDTxhPsDf
         FJb61mDTr7FP8dT4tGC/FAZ5eZB5qYmrSyjbqP3Dn5JlyyxHnMdI7dl86Xv3RU3yvN
         BT5jK4sW7IsvJ8a0Qb298PlGxVOzMS5JkCdnGqEKoSuqnsCl/Bwvf0wma2d+pl8eEA
         zbVqHfzQVqHttd9e/EXcocyFQw2Bk7K/Rpy4pmKp7cPMobWVZJuZE3gShuGhrvJg4W
         ZWpMYMkSTfkFw==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-176d93cd0daso5864449fac.4
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 05:42:10 -0800 (PST)
X-Gm-Message-State: AO0yUKWaEHM0MrH/WkpfrhSvAATiL9YN29QcTTHrWgIApbNKXBWjSTKG
        CZfh94yfcnf9a1Fbhp74ih+dPF4HSqKJ0PQysMw=
X-Google-Smtp-Source: AK7set+ZPGdYuUHZAwEsbVYg4EPZN1i54fG0IzRKyehiMk+6K5PK0j9bfdwUoTEJi0cGcmBrTAlapyCeC6kXqYh/sls=
X-Received: by 2002:a05:6870:b312:b0:176:6231:fc7a with SMTP id
 a18-20020a056870b31200b001766231fc7amr1056048oao.3.1678455729804; Fri, 10 Mar
 2023 05:42:09 -0800 (PST)
MIME-Version: 1.0
References: <4508efb976dddf7ca5be98f742de2db4db677ab2.camel@gmail.com>
In-Reply-To: <4508efb976dddf7ca5be98f742de2db4db677ab2.camel@gmail.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 10 Mar 2023 13:41:33 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6FuWMcoGwzLG+CscQ3Xc=M4Y75Vw81efquvY-s7_9CTg@mail.gmail.com>
Message-ID: <CAL3q7H6FuWMcoGwzLG+CscQ3Xc=M4Y75Vw81efquvY-s7_9CTg@mail.gmail.com>
Subject: Re: Utility btrfs-diff-go confused by btrfs-send output - a file
 isn't changed but is associated with an UPDATE_EXTENT command
To:     Michael Bideau <mica.devel@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 10, 2023 at 1:24=E2=80=AFPM Michael Bideau <mica.devel@gmail.co=
m> wrote:
>
> Hi all,
>
> First, thank you for the btrfs FS and all your work.
> This is my first interaction with this community and I'll try to communic=
ate to
> my best.
>
> I am developing 'btrfs-diff-go' (https://github.com/mbideau/btrfs-diff-go=
), an
> utility that analyse the output stream of a 'btrfs-send' command, and pro=
duce an
> output like the 'diff' utility to visualise which files/directories have =
changed
> (and how) between two btrfs subvolumes/snapshots.
>
> While I was testing it I encountered an issue: some files were detected a=
s
> changed, when they where actually not (no difference with 'diff' nor
> 'sha256sum').
> With my program's debug log I found out that it was related with the
> UPDATE_EXTENT command, always interpreted as a file change.
> Digging into it I ended up in the 'btrfs-send' source code and found out =
that
> this command was used when data actually has changed I guess (in function
> 'send_extent_data'
> https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/tree/fs/b=
trfs/send.c#n5682
> ), but also for "holes" (in function 'send_hole'
> https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/tree/fs/b=
trfs/send.c#n5456
> ).
> I couldn't debug further nor check myself (according to my current free t=
ime and
> knowledge), but as I read the code I understand that the function
> 'send_update_extent' always send a path, and maybe that path is wrong or =
should
> be empty when sending a "hole" ?
>
> Could you please help me:
> - to reproduce a simple test case that send the UPDATE_EXTENT command for=
 a real
> file change and for a hole ? This way I could acknowledge properly the is=
sue in
> my program 'btrfs-diff-go', and later on the fix.
> - to understand what's going on ... Is a "hole" an actual file change eve=
n no
> data has changed in that file, and if so, how I am supposed to filter the=
m out
> to only report real data changes to match 'diff' output ?
> - to report this as a bug if you think it is one ?

There at least a couple reasons why an UPDATE_EXTENT command may be
sent yet the data in the file did not change:

1) The file is fully or partially rewritten with the same data - for
e.g. running defrag - this only changes the extent layout - but we
have no way to quickly and efficiently check it's the same data, so we
send the UPDATE_EXTENT command - it may also be interesting for some
use cases to know the extent layout changed - so it's not necessarily
a bad thing;

2) A hole is punched into a file range with all data bytes having a
value of 0. Or an application writes zeros to a range with a hole, or
calls fallocate against a range that has a hole.

If you find a case where the extent layout is exactly the same and no
data changed, then it's a bug (although a minor one as it didn't
incorrectly change the file).



>
> See also:
> - btrfs-progs sending UPDATE_EXTENT command:
> https://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git/tre=
e/libbtrfs/send-stream.c#n455
> - btrsf-progs receiving UPDATE_EXTENT command:
> https://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git/tre=
e/cmds/receive.c#n986
>
> Thanks in advance for your time and answers.
>
> Best regards,
> Michael Bideau [France]
>
