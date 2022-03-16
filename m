Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2BC4DB819
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Mar 2022 19:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239276AbiCPSsS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 14:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbiCPSsQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 14:48:16 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3213C4B1
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 11:47:02 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id b188so3274804oia.13
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 11:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMyuQirD0hyqmquTi4Vo87ENX2HU3ytWAnN40oSreSc=;
        b=dEomp0X5evpplDNR4mw6NZ6FS/DtBA5gWgaNQrAA8+ApbJfb2k8q03PtuTcS1vOgJ4
         3Gs/itM0T6zzPlZ9PJPVEoXH1RS8hJmmlk6Crz6LX5Ndz4p6TzvZkrfdPfo/zuiki02C
         oMHX1FFwcJQeK9uBCTEa9/YDd3x7oCi/iTyZl9FnJ/RPIcsfpXCrVLi+9seiVFIWPcvj
         Biauf4jih1ekCyJ4egM+o4OqpcxibD1amaiQlQqmZKUiiwn86gx0mIu5susLqVtrPLbG
         RzThp9SSxcxFPs8DMgeKB1Pymxb3k6cQ0VW9RzmVzSIcORHnomPL0JiEMsGHoeA70a3O
         EQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMyuQirD0hyqmquTi4Vo87ENX2HU3ytWAnN40oSreSc=;
        b=RY5H94SHO9xc/9nIvdZjGAV3Mw8CsKCeUoz7MpuEikcM3gENx7ol1ZKaeUqkp5gJzv
         lEoJttRH7Klmu7xZ/QQ0DlkJzVWDN3OylINBGWoKyZGN/WS36rfNyfECeAIenTALpbV6
         OoZt1G2Fmw8FB690eWTWmdMPz2BOoJxkSHnklNIcL5xYXhv3ceDeILUzhcnqf+qWg/TN
         Rs0ZZKWLw/51C2cPzX35p7hThHZBco0TAj94dkQ3hPfBT32RaRcmMfxtFWFzd46RRiKS
         H7K71jD5Gns4CFC3wi/cu1FczUJE2j3FHcvxdPXlD9A8kcfpG75eeVSurLHcMbGpGruc
         xtEg==
X-Gm-Message-State: AOAM530EY1zdhWmQmfRb1ee6Pe1zbF8wAMXXzhS0fYb6VaGbvL50E22M
        WIhXDL1ht4iHPka5iBHWhwS6HJIsclUPnUfv+FXkMNhNzPuMdA==
X-Google-Smtp-Source: ABdhPJwDP7RuyG18Z9LE8kUDHSNKF/uBkXNHrixN2vxhhJakUV9ZLaelUuU00pxV+Qk/gd0USIRFUEocelx2iukIYMI=
X-Received: by 2002:a05:6808:2117:b0:2da:5906:22c3 with SMTP id
 r23-20020a056808211700b002da590622c3mr461296oiw.80.1647456421448; Wed, 16 Mar
 2022 11:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <87tuc9q1fc.fsf@vps.thesusis.net> <CAODFU0py06T4Eet+i0ZAY5Zrp5174eQJOCGh_03oZdDXO55TKw@mail.gmail.com>
 <87tuc7gdzp.fsf@vps.thesusis.net> <CAODFU0oM02WDpOPXp1of177aEJ9=ux2QFrHZF=khhzAg+3N1dA@mail.gmail.com>
 <87ee34cnaq.fsf@vps.thesusis.net> <5bfd9f15-c696-3962-aaf9-7d0eb4a79694@gmail.com>
 <87bky5wxt6.fsf@vps.thesusis.net>
In-Reply-To: <87bky5wxt6.fsf@vps.thesusis.net>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Wed, 16 Mar 2022 19:46:25 +0100
Message-ID: <CAODFU0oPbRQ02sCrZeF2vKueGLtkR_MgDPd04x7ZVR5+ZufTQg@mail.gmail.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
To:     Phillip Susi <phill@thesusis.net>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 16, 2022 at 7:35 PM Phillip Susi <phill@thesusis.net> wrote:
> Andrei Borzenkov <arvidjaar@gmail.com> writes:
>
> > btrfs manages space in variable size extents. If you change 999 bytes in
> > 1000 bytes extent, original extent remains allocated because 1 byte is
> > still referenced. So actual space consumption is now 1999 bytes.
>
> Huh?  You can't really do that because the page cache manages files in
> 4k pages.  If you have a 1M extent and you touch one byte in the file,
> thus making one 4k page dirty, are you really saying that btrfs will
> write that modified 4k page somewhere else and NOT free the 4k block
> that is no longer used?

The questions "Why ... will it write that modified 4k page somewhere
else?" and "Why ... not free the 4k block that is no longer used?" are
two separate questions.

In any CoW filesystem, the answer to the 1st question is: because it
is a CoW filesystem. Because it is a basic assumption/premise of the
filesystem's design.

The answer to the 2nd question depends on whether the CoW filesystem
is well-optimized to handle such a scenario or not optimized to handle
such a scenario.
