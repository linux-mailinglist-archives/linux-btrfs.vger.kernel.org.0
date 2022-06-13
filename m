Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E57549CD3
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 21:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345322AbiFMTFZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 15:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348075AbiFMTDi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 15:03:38 -0400
Received: from mail-4027.protonmail.ch (mail-4027.protonmail.ch [185.70.40.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F02ADBD2
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 09:46:35 -0700 (PDT)
Date:   Mon, 13 Jun 2022 16:46:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail3; t=1655138792; x=1655397992;
        bh=xsI1YwOp/AhrN0sOCzdg8amKFpx7cl4xkciCNGq3mp4=;
        h=Date:To:From:Reply-To:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=kncMgYXt03gLhi4814UZ90a0wXpohWO+SMI6O8LYI5gML5g639o0P+AOBjoVjXmYv
         kCgaaIbTNbJgxqwNFiTEMxuEyDsTmztiqWDYNrwGMvqjvyMxzVWieINtaaEMxrEztE
         E4bgEzRPE+bGnlKvQAI+DvZnBK9x3L8rdEcqLZcdi4JBc8epB/zspHJvo5v2uc7Dmc
         c3a+YfvPlURbmxtFhhteV26G/FiamiqvVyBVaAYBri5TYHQzkY8sMix0ptI7v/+tfG
         WlT6nwtBWJZNWsOZhFdzl7LerFL4sM0FXNoBgtDro8M8eUP9iCMIMVDdWGH9O9GsuZ
         yEwiEIqM7uS2Q==
To:     Forza <forza@tnonline.net>, Hugo Mills <hugo@carfax.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Neko-san <nekoNexus@proton.me>
Reply-To: Neko-san <nekoNexus@proton.me>
Subject: Re: [Help Please] Missing FIle Permissions Irrecoverably
Message-ID: <EmTySX_q4q6PTbokDxBQq-fd67uligmNUgZkPtTi_PE13jz2i9st5R8YYH2RRDHicLXUUE_nec-pGVWmqT3zV601A1C-FMlAoTh1nErH_GE=@proton.me>
In-Reply-To: <2N67hfOUtyAxwzQi9pHQi9q1nbVd-bgQY0_Yj88FCkbXbQMPoFza3VBLmrCj6FcPzWNJhAtlczURDXzu2oB-BvqDebve4KnV5R64VXyf97Y=@proton.me>
References: <LQBIObJ0wXAJiClnJItZ5QlGJPGLx5G3_cbQYB6Yle5t7wg7-MX233_rkpCs_ybzN9-DWoQBSlPD6EZRa6HDjdo6PWJjFWO0qb4XB7UsK1E=@proton.me> <20220520212751.GE22627@savella.carfax.org.uk> <VHT1Yf4pw4jirz6QjpYj6bPb1zvJ06WStOXc4w1mSC1A7DsH5YQq-mqvzkzZSZriBXwCHuyF11thmlcgSLYFGaBeHGuA5XliXPJVJ3eXItE=@proton.me> <J6n7dr0d6RAArHrDWGrU_uNQsM56Npqpp_tuyXoY7q4rS_2dPzmd4sH14t_w-n_tE80HWdjyUKY2SqwV-iFwBoa55dLfJ3WI7LVsrjTRTVw=@proton.me> <uDip5WTKD2tJ6uP8N0eW91dNpbSShUrHBHPLczGV4l__Z_Wem9uWnG_pCYqcYjren8Gx8Va0iS3AGvCEiFTAC33Lgx_gOMs9KVqb1dh_lnc=@proton.me> <wztQTaGfQNKnobWabVzov7npkcVSeXD2Zth69WUFRit2NRq61hMN6a7t6R9mJntS0kyDryBabwpzmP4_q4nsO8y9WnUX35nOJ3ZF0agom9M=@proton.me> <98b7da2.8b0b192.1810759a875@tnonline.net> <2N67hfOUtyAxwzQi9pHQi9q1nbVd-bgQY0_Yj88FCkbXbQMPoFza3VBLmrCj6FcPzWNJhAtlczURDXzu2oB-BvqDebve4KnV5R64VXyf97Y=@proton.me>
Feedback-ID: 45481095:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I was hoping I could get even a sliver of advice after providing that infor=
mation by now...

Is it even safe to run "btrfs check" normally to attempt to fix this?
I haven't had an absurdly difficult to solve issue like this in a very long=
 time...

------- Original Message -------
On Wednesday, June 8th, 2022 at 2:09 PM, Neko-san <nekoNexus@proton.me> wro=
te:


> > Support is given by the community as and when they can and want to.
>
>
> I'm aware... I just find it irrate that, as a supporter of BTRFS myself, =
I can never seem to get help with it no matter where I go. It makes it an i=
ncredible struggle for me to advocate for it when I, personally, never rece=
ive support for it.
>
> > Did you have some power loss or over temperature issues with the nvme d=
rive before these problems?
>
>
> No, I didn't
>
> > Best is to try to boot with a live usb and run a 'btrfs check --readonl=
y' on the unmounted drive. Check cannot reliably run on a mounted filesyste=
m.
>
>
> I'm attaching the log I made of having done that to this reply; hopefully=
 it helps somehow but my expectations are low
