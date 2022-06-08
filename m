Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBC454323D
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 16:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241004AbiFHOJj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 10:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241000AbiFHOJh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 10:09:37 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9088C1842C5
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 07:09:35 -0700 (PDT)
Date:   Wed, 08 Jun 2022 14:09:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail3; t=1654697371; x=1654956571;
        bh=6DR8gZZhXxUc7DEq7dxcE3wpFStZxk2N2nH1b4wrsvs=;
        h=Date:To:From:Reply-To:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=kPmvax5pdzi84g6Qg9uHnYWmjzLBPsgNyYsa4CuE5OsIOLoKBo2D/IKb/+EbpIRyW
         OMxpSWC+7K6C1RePBaT1kDhYT0sZDWMTqnh/b6FOC6+rQ23EBslw55dsnts4qi7Yt6
         xSfv4zO3H1TD8WbA2wbOVe6/2M0NSFZj6J/BGAHmfaOOuCf6Z+Xb5hBGyYs5KmTltL
         TzljVNupvZvkwZtfJJb9szpyGfz8sbgO/Kxzvk5vytaEZ2BmfZF175r7qupGNcfxr0
         ENMNCXk3czy+3HwvnP5xvEh/LGDX1dfRv0Pbq/AfLcXu8hRSR3uoV8AubmosQmuBaf
         GdusbBpw7H3kQ==
To:     Forza <forza@tnonline.net>, Hugo Mills <hugo@carfax.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Neko-san <nekoNexus@proton.me>
Reply-To: Neko-san <nekoNexus@proton.me>
Subject: Re: [Help Please] Missing FIle Permissions Irrecoverably
Message-ID: <2N67hfOUtyAxwzQi9pHQi9q1nbVd-bgQY0_Yj88FCkbXbQMPoFza3VBLmrCj6FcPzWNJhAtlczURDXzu2oB-BvqDebve4KnV5R64VXyf97Y=@proton.me>
In-Reply-To: <98b7da2.8b0b192.1810759a875@tnonline.net>
References: <LQBIObJ0wXAJiClnJItZ5QlGJPGLx5G3_cbQYB6Yle5t7wg7-MX233_rkpCs_ybzN9-DWoQBSlPD6EZRa6HDjdo6PWJjFWO0qb4XB7UsK1E=@proton.me> <20220520212751.GE22627@savella.carfax.org.uk> <VHT1Yf4pw4jirz6QjpYj6bPb1zvJ06WStOXc4w1mSC1A7DsH5YQq-mqvzkzZSZriBXwCHuyF11thmlcgSLYFGaBeHGuA5XliXPJVJ3eXItE=@proton.me> <J6n7dr0d6RAArHrDWGrU_uNQsM56Npqpp_tuyXoY7q4rS_2dPzmd4sH14t_w-n_tE80HWdjyUKY2SqwV-iFwBoa55dLfJ3WI7LVsrjTRTVw=@proton.me> <uDip5WTKD2tJ6uP8N0eW91dNpbSShUrHBHPLczGV4l__Z_Wem9uWnG_pCYqcYjren8Gx8Va0iS3AGvCEiFTAC33Lgx_gOMs9KVqb1dh_lnc=@proton.me> <wztQTaGfQNKnobWabVzov7npkcVSeXD2Zth69WUFRit2NRq61hMN6a7t6R9mJntS0kyDryBabwpzmP4_q4nsO8y9WnUX35nOJ3ZF0agom9M=@proton.me> <98b7da2.8b0b192.1810759a875@tnonline.net>
Feedback-ID: 45481095:user:proton
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_lBoOdhURWHAOvhDjTDEC9YioAdMa6dwX6KP2U1HA"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.

--b1_lBoOdhURWHAOvhDjTDEC9YioAdMa6dwX6KP2U1HA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Support is given by the community as and when they can and want to.

I'm aware... I just find it irrate that, as a supporter of BTRFS myself, I =
can never seem to get help with it no matter where I go. It makes it an inc=
redible struggle for me to advocate for it when I, personally, never receiv=
e support for it.

> Did you have some power loss or over temperature issues with the nvme dri=
ve before these problems?

No, I didn't

> Best is to try to boot with a live usb and run a 'btrfs check --readonly'=
 on the unmounted drive. Check cannot reliably run on a mounted filesystem.

I'm attaching the log I made of having done that to this reply; hopefully i=
t helps somehow but my expectations are low
--b1_lBoOdhURWHAOvhDjTDEC9YioAdMa6dwX6KP2U1HA
Content-Type: text/plain; name=btrfs-check-readonly.log
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=btrfs-check-readonly.log

WzEvN10gY2hlY2tpbmcgcm9vdCBpdGVtcwpbMi83XSBjaGVja2luZyBleHRlbnRzCmRhdGEgYmFj
a3JlZiAzNTUwMDQyMTEyMCByb290IDUgb3duZXIgODQyODkzMzkgb2Zmc2V0IDAgbnVtX3JlZnMg
MCBub3QgZm91bmQgaW4gZXh0ZW50IHRyZWUKaW5jb3JyZWN0IGxvY2FsIGJhY2tyZWYgY291bnQg
b24gMzU1MDA0MjExMjAgcm9vdCA1IG93bmVyIDg0Mjg5MzM5IG9mZnNldCAwIGZvdW5kIDEgd2Fu
dGVkIDAgYmFjayAweDU1NjNjMGFiMzZiMAppbmNvcnJlY3QgbG9jYWwgYmFja3JlZiBjb3VudCBv
biAzNTUwMDQyMTEyMCByb290IDUgb3duZXIgODQyODkzMzkgb2Zmc2V0IDQwOTYgZm91bmQgMCB3
YW50ZWQgMSBiYWNrIDB4NTU2M2JkNzQ2MGMwCmJhY2tyZWYgZGlzayBieXRlbnIgZG9lcyBub3Qg
bWF0Y2ggZXh0ZW50IHJlY29yZCwgYnl0ZW5yPTM1NTAwNDIxMTIwLCByZWYgYnl0ZW5yPTAKYmFj
a3BvaW50ZXIgbWlzbWF0Y2ggb24gWzM1NTAwNDIxMTIwIDE0ODY4NDhdCkVSUk9SOiBlcnJvcnMg
Zm91bmQgaW4gZXh0ZW50IGFsbG9jYXRpb24gdHJlZSBvciBjaHVuayBhbGxvY2F0aW9uClszLzdd
IGNoZWNraW5nIGZyZWUgc3BhY2UgY2FjaGUKWzQvN10gY2hlY2tpbmcgZnMgcm9vdHMKWzUvN10g
Y2hlY2tpbmcgb25seSBjc3VtcyBpdGVtcyAod2l0aG91dCB2ZXJpZnlpbmcgZGF0YSkKWzYvN10g
Y2hlY2tpbmcgcm9vdCByZWZzCls3LzddIGNoZWNraW5nIHF1b3RhIGdyb3VwcyBza2lwcGVkIChu
b3QgZW5hYmxlZCBvbiB0aGlzIEZTKQpPcGVuaW5nIGZpbGVzeXN0ZW0gdG8gY2hlY2suLi4KQ2hl
Y2tpbmcgZmlsZXN5c3RlbSBvbiAvZGV2L252bWUwbjFwMgpVVUlEOiA1NzYxZjI3Ni05ZjQ3LTQx
OTUtYTViMi1jMjFmZjRmM2ZlYTUKZm91bmQgMjAxODUwOTk4Nzg0IGJ5dGVzIHVzZWQsIGVycm9y
KHMpIGZvdW5kCnRvdGFsIGNzdW0gYnl0ZXM6IDE5NDMzODYxNgp0b3RhbCB0cmVlIGJ5dGVzOiAy
MjEzODU1MjMyCnRvdGFsIGZzIHRyZWUgYnl0ZXM6IDE4MjE1MjM5NjgKdG90YWwgZXh0ZW50IHRy
ZWUgYnl0ZXM6IDEzNDk4Nzc3NgpidHJlZSBzcGFjZSB3YXN0ZSBieXRlczogMzk1NDQyMTg1CmZp
bGUgZGF0YSBibG9ja3MgYWxsb2NhdGVkOiAzNzAxMDUzMzE3MTIKIHJlZmVyZW5jZWQgMTk5MDY0
NDI0NDQ4Cg==

--b1_lBoOdhURWHAOvhDjTDEC9YioAdMa6dwX6KP2U1HA--

