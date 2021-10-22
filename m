Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AB94376F9
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Oct 2021 14:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbhJVMYe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Oct 2021 08:24:34 -0400
Received: from iblc005.ib.pl ([185.38.250.156]:50370 "EHLO ib.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232410AbhJVMYc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Oct 2021 08:24:32 -0400
X-Greylist: delayed 1006 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Oct 2021 08:24:31 EDT
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed; d=ib.pl;
        s=20200714201541; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Subject:To:From:Sender:Reply-To:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8b3dmurWWhrbSSc0i7JMsKirB0fjY/aX+0g1RkoyP0A=; b=nBvJ3Dt38YFuSdK5osIjFEqrPi
        sY6gbag8a9/7Y3ATT0fTtHsoS8AQu4y8G9oeG8wJMnKvTbyJlRdN0DPKLFBw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ib.pl;
        s=20200714201541bc; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        Date:Message-ID:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8b3dmurWWhrbSSc0i7JMsKirB0fjY/aX+0g1RkoyP0A=; b=IqPRr2WB7DHHicMAIV1Cr33Gfx
        kp33T+tfxdBuRylWzzLpnzJOJ2emY+C9tI7Yqcgz8Hd85FMnbuiZF3pzZBUiwVVXkhjkQbIF7yHS0
        qFONh0ULxizjnMd6C6fRNeIZUXhre8zIoHH2gEOzCfGyYqkoCl85Y6W680WDJAdW3O1/U+HWtitsA
        s9eJDRa5Q7soGjAX1FRL/XUs2hNQTZzuZ+zQn0h1Pd2Gi6jrAARn4+mvK0hBUb3cOn4awFy+JdPLo
        eGsiumHxyAsMFUNlyx5Khyrd5B42J6rBSINmEGFJQCLHNs/4B+AVVxUK8qaU6BznyrcBRW+KB+LTA
        aYDerITg==;
From:   IB Development Team <dev@ib.pl>
To:     linux-btrfs@vger.kernel.org
Subject: send/receive backward compatibility question
Message-ID: <7df25e10-df12-0581-c8ce-fa2387001d57@ib.pl>
Date:   Fri, 22 Oct 2021 14:05:25 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: pl-PL
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Man pages

https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs-send
https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs-receive

do not say anything about kernel versions required on sending/receiving=20
side.

Is possible to do btrfs send/receive between systems with different=20
kernel versions, i.e. sender with newer linux kernel 5.10 (btrfs-progs=20
v5.10.1, debian 11) and receiver with older linux kernel 4.19=20
(btrfs-progs v4.20.1, debian 10)?

Does "btrfs receive" protect against applying incremental snapshot diff=20
in case it's not compatible with btrfs FS on receiver or admin must take =

care of compatibility checks "manually"?

--=20
Regards,
Pawe=C5=82 Bogus=C5=82awski

IB Development Team
E: dev@ib.pl


