Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57B35ADF04
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 07:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiIFFdO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Sep 2022 01:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiIFFdN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Sep 2022 01:33:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7C16DADC
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Sep 2022 22:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662442389;
        bh=ar4xgRP8/NJrVnkUkIcjb0MlzlcMW829uzxwwyv1i9k=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=GtO98by7Q86pdaBz5Fx3joZqENOLosKI5FrX7Fi1Mq6kUlT8pUGRjT6zySEXdGjTq
         vdeO1yOkPpWh+HRNH1YAUz+d3N7i5zsI4wgodGAzX6aqCOIHxE0Vj3ON0FJ87D70uj
         KY1zAuYxWRMtpu7DianrJ37y3Y6DVyOgZ3EYV4Jw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [87.122.254.172] ([87.122.254.172]) by web-mail.gmx.net
 (3c-app-gmx-bap71.server.lan [172.19.172.171]) (via HTTP); Tue, 6 Sep 2022
 07:33:09 +0200
MIME-Version: 1.0
Message-ID: <trinity-5dc69f90-9c41-4b10-9294-aaaddc708c8b-1662442389621@3c-app-gmx-bap71>
From:   Steve Keller <keller.steve@gmx.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: RAID1/RAID0, online replace
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 6 Sep 2022 07:33:09 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <d759fd64-fe5c-491e-9c24-c27067cbb195@www.fastmail.com>
References: <trinity-2ed29f2d-59e7-439a-893d-3fc3b41be07f-1662419772647@3c-app-gmx-bap56>
 <d759fd64-fe5c-491e-9c24-c27067cbb195@www.fastmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:yvgXn98TIYbGGQfoPNugGMMnI1DfWTLufLqilkV9Ij/4UOQgLa41fMS9Q44eOVXU73cKA
 5+5Ueez3fwmZMA31G4ZEBZ8r+Urg5r4YXLAGJR4RqvXM2NmonkTAhWbrS934ymaClT3tAjnESK15
 jQ2cOIY/At0sVdFXUp+OVgLVDrfquBYcQixUq07KI+mgudfVQFFaVBNaYSSH2NAGpWufuwrTgpsw
 QV0XqMaZ/4F6h2H+9niTqiY3z7Dxs5IPbby7xAwSjDVMQijJ2VAUWBiHkZkrXtrBjibF9a5UCP56
 Vs=
X-UI-Out-Filterresults: notjunk:1;V03:K0:FkCLC8SY7yQ=:myHZD/IMevdBFMIGiS9dpD
 bU83gTMKTfjFjP3OQ+1R0iVfIvhT7gI27yHkCNvKEcO7iWgdpJza5gortG+WCj6ul+OLgGthT
 KS5VQLmAMCrEEattnARHUmjLVQJ+PgrAMmVVwqrZtF4B0+Ead2UBiWY8AHRY0OMwGGvt/8rj0
 3ILSpXo0Hu+QnUNXX+z6Y1DQPiS14m7YPt/ic9M3pIt+gEa3LYxxfxnPZWCqhzilFgCdY2QHR
 oWO3hSxdFyDysvxekczZvfFY/nKaq07yNO8GxIqJkcAC/xDz/otmRc5uuYdiHzwGTThhsR8UP
 HymOUcIfurFT66oyfrGZtmS42WHSlmBnDslxuOLw0n2+XAVUQyxaerHeFGfAgYzHlIUNANkR8
 MGP/cfmyX5ns3r7GFLdcwLc0QqJbz/RFr407YN65bh/ans8d2eJ3XY0TVrpl9Z313eY78P80C
 3rYFKGLzr5h+177W9J7rZgDjps5AZ17tgl1MGIJ95cUHwXvqGuULbSujJHPgPvRhdI2GoL5Cc
 RDoY/1SWI97GAeO6SkIhs8gmLGmGDqoL9AFEcMMXYR0F7NQqZWHJVwBfjZbLCu5s0MwNCFaY1
 L+XbGv+YH7Uz3NjX4Ha2ZU/mkrq4IglihMfYK0UMC3G6dXXDqaI8BlZK2J8id/fOvBtTDtXWh
 zIqeRrAq5ggLFqhyp/7zfiFL7/8wB5voVQK9hmFp0+1thhvR/sW9Nvdw1s4di2570VqDlfu1v
 GsY0XLZ5FkCylCW8/gPH0D5cGQZv8cH+jRgoVIy98MA+Kw9XofqgixnhUH2Za9iKeYz/+2ITL
 nUBI5te
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Chris Murphy <lists@colorremedies.com> writes:

> Ostensibly it's all one profile per block group type. But if the
> conversion was interrupted or cancelled, yeah you'd have mixed
> profile block groups, thus some files could be one or the other. But
> this is not really controllable.

So, you couldn't even have different RAID config per subvolume, right?

> `btrfs replace` is an online command.

I read that the default is RAID1 for metadata and RAID0 for data.
But that would mean that in case of a disk failure almost all files,
i.e. those which have at least one data block on the failed drive,
are damaged. What does 'btrfs replace' do with these files? Isn't
the purpose of RAID defeated, when in case of disk failure most files
are damaged and you need to restore from backup?

AFAIU, RAID should allow you to continue with no need to unmount or
downtime, no restore from backup, if a disk fails. You would get
that with mkfs.btrfs -m raid1 -d raid1. The default
mkfs.btrfs -m raid1 -d raid0 doesn't make sense, IMO. But useful
would be a mixture of RAID0 and RAID1 for data, where I can configure
which files or directories or subvolumes use RAID0, e.g. directories
of large files, which change seldomly and aren't essential for normal
work, so that restore from the backup storage wouldn't mean loss of
work since last backup and interruption of work.

Steve

