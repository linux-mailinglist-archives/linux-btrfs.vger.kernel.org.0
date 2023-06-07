Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA7C725DAA
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 13:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239048AbjFGLvZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 07:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238429AbjFGLvY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 07:51:24 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231331BC6
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 04:51:23 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f628cc4a35so682331e87.0
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 04:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686138681; x=1688730681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDzoBbmHlENuqsBoE9mzQ+yvZBxmEDCstPgfYaVE+0E=;
        b=WLq+W6vlPrSAta/FCNzfu4BKEa5c5hcgxFZzv38mteLmdZhq4GWFzG7QarkSLcXSBU
         DlwdvTuMqYYfqWAZyh/dVM/nqKfPNHEdWjrg7DYqw9RfdxC+QBIXVH83fU0eA+zEhB3F
         ZYwDA2nMX7RcKY/2OLMSqtbVi3J3zQZGrqlpLDC4mWtSkw3emruNQErkg4xOYhh3MQiZ
         e/TAlCh19NlmpNXOeA5ZpG/JyKv9QqI++Pvitxj6vaGbNDgtsmYh4FvrlVEDYXKvWqwW
         hUyRzIEz/+U+eX9w4sAjZz/yNaXSuwKJIeUMgu9HMmR3591Y9l1NAuHIKCWXgbgDQ6p9
         H5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686138681; x=1688730681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDzoBbmHlENuqsBoE9mzQ+yvZBxmEDCstPgfYaVE+0E=;
        b=a7WNSoaf2kdQzrCrwQ+BGO15Y8niqAe6xfHsa/7vvgBkjRpTwPvZ1XeTRCHkNGbZ5w
         hSxsTyNsa4ZgI9i9m6NQz6zdku5JdA2ScDo95M/1KCG67I4tnIAD+NsF+Ccm/05LUsOT
         2paG6OPfeOHTE+2VmRUgFd37z3aslKLBrApbQDZpEfzUPZcsreHzmSz9GWeEVuMpYuDx
         jFd2TdDCW+s9oivnIRK3zSmPCpUdyJKvR4Vg0xe1lw/331SrfN8+NgBUftIOcj/sM+Dj
         uOnSmqhz44qh2XpnkeZgwDDSGiIGTdHGPf8x/pOTiBaPUNJGTYmwMy1Y2kLvtdwUorj9
         W33w==
X-Gm-Message-State: AC+VfDzeDHYoFaCC/NAwnKSFs6LTKqeDpy78JFJB4DMxMLmhOZXY8UEi
        sQ5qrHIEAO23eZbMu5rd8wvVUeybUuYcgcBN+0OW9hN2
X-Google-Smtp-Source: ACHHUZ7PMA5zJ2M/zJ47gkwd/tWew756RGhJRn2XeGNhfEC3BhDX936mFSqedQbIRdSbrHH5Qw7T2GDda+2oEbt2ehQ=
X-Received: by 2002:a05:651c:381:b0:2b1:c077:8d9 with SMTP id
 e1-20020a05651c038100b002b1c07708d9mr1776587ljp.4.1686138680843; Wed, 07 Jun
 2023 04:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <PR3PR04MB73400D4878EB0F8328B5D50BD652A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <26251cfd-f138-a787-f0e8-528c1c5c6778@gmail.com> <PR3PR04MB7340EB60FBF52F117181580ED653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
In-Reply-To: <PR3PR04MB7340EB60FBF52F117181580ED653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Date:   Wed, 7 Jun 2023 14:51:09 +0300
Message-ID: <CAA91j0UEFygxv=p1Tb=uWNw57ao-k9Q4+LvicxFyezvGC-c9CA@mail.gmail.com>
Subject: Re: rollback to a snapshot
To:     Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 7, 2023 at 1:38=E2=80=AFPM Bernd Lentes
<bernd.lentes@helmholtz-muenchen.de> wrote:
> >
> >You cannot rename or move because you cannot "rename" or "move"
> >subvolume to become filesystem top level. Which is one reason why you
> >should never use btrfs top level subvolume if you plan to use snapshots =
and be
> >able to revert. Actually you should probably never use btrfs top level
> >subvolume except as container for other subvolumes. Period.
>
> Could you propose a setup here which does not use top level subvolumes ?

In case I was not clear - I mean using top level btrfs root (subvolume
ID 5). Of course there is no problem using subvolume directly under
root (like /root1, /root2 etc).

> I found it very frustrating that everyone says "BTRFS is great, you can d=
o snapshots and easily rollback".
> Because in reality rollback is not easy.

Again - you can always rsync back. Or use any other directory
synchronization tool to bring your original subvolume to the same
state.

> How can i avoid to use top level subvolumes ?

That really depends on what installer of your distribution offers and suppo=
rts.

> I have some Suse boxes which seem to have a correct default setup.

They started it with the wrong one and had to change the setup exactly
due to rollback problems.

>  But when i install e.g. an Ubuntu box
> i really don't know how to setup BTRFS manually.

The question cannot be answered globally because it depends on tools
your distribution offers. The SUSE setup is correct for SUSE tools and
"foreign" tools have problems with it (like grub2 using different
rules to resolve path names on btrfs).

If you are going to do rollback manually - you set it up so that you
know how to rollback. Otherwise it should be described in your
distribution guides.

> >- as mentioned already, do not flip read-only snapshot to read-write, ra=
ther
> >create new writable clone.
>

It breaks the replication chain. You may not be using it right now,
but should you decide to use it, it is better you have the habit of
doing it right. Just look how many reports about replication problems
on this list were traced back to ro -> rw change.

And it is useful to have the original snapshot as a reference so you
always have your known good recovery point.
