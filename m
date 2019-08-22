Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 915BC9985A
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 17:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732536AbfHVPkg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 11:40:36 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39572 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731416AbfHVPkg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 11:40:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id x3so4878389lfn.6
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 08:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cXGljeB99bXUDWMB64Bv9wKPC4CRt8+++/6B34P0I2g=;
        b=en0JZibSEhonSSvBSAk0Rg6qZtoqIL9SzWmBP17m29Lgw3EigbJOJI31XB+FCfQRl6
         sKZkNydu1/GTkpx947dl/T9PtiK8Kp68vMxDNHHr/8iLxmBPvyThpjGsqJPrMYaJPgv3
         lQuI99mLd1viyQZu41iAcMkm96qZoEpL6toziBn94zV0nVRR6/uPejhb/MFX/ngt3noT
         6gYPlWgeQmPAk99xaGq+p+bseDxeEgnql4DCs+n1oRClO/Jf06Am6w6p2G6yhudJoYK6
         F5xFS1oOq+Ip+os5kAVZRr4YxUzZexhdfRso6QoJmti6VjSXFxZceW6mdNlFuP5uAuYl
         /YYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cXGljeB99bXUDWMB64Bv9wKPC4CRt8+++/6B34P0I2g=;
        b=M9ixFN10bl8C9JxXuAJOb9Nhsuojt6TfSo6sReuY7g98QFJ/gCs+4uV8/RXvTW6jnt
         SHqaqWKiA8NJ6SOyKd0mjqPyIQ6o8pNQJZdMSgPC04FOgd8EkkGHSmUrgNiYUR1GiGyF
         DDxQZt5RBp7xWA2iD29UGxw5VaaHys1OidmQWaJ150vW1spUD15S8PobMlU0D8JnPiSQ
         3xNHkSb/WjCTrm231vHBWcMsuPBt/quLE+7y0svUDgCRNcQgPPOUQnIPqi2hPjKn7qTP
         ZxKNwmkFl6nVGIO5ZyvBcYbXtHIiLxGrN7LStvmeGYw3Qk7aCayRinB/1Pk1zP8G12aV
         Ul0A==
X-Gm-Message-State: APjAAAUIoxP3Q2ogiKde/Kq+VlSaRF32eowS2F9+pX12jE767fK9+VTM
        mledpb0oyVQ2G4Gt10vmg1uaxxFegG/BkZquVsFXDwBgWTw=
X-Google-Smtp-Source: APXvYqyr6Wv9x5Tqn5Zk9k4yRgd6paSqbgx6j1NicWeI2Uhmqne0rNYcgnVe/7IPlfLT3sYkkF5doszFssKsF6hooSQ=
X-Received: by 2002:ac2:592f:: with SMTP id v15mr4672208lfi.57.1566488434149;
 Thu, 22 Aug 2019 08:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190822114029.11225-1-jthumshirn@suse.de> <ed9e2eaa-7637-9752-94bb-fd415ab2b798@applied-asynchrony.com>
In-Reply-To: <ed9e2eaa-7637-9752-94bb-fd415ab2b798@applied-asynchrony.com>
From:   Peter Becker <floyd.net@gmail.com>
Date:   Thu, 22 Aug 2019 17:40:23 +0200
Message-ID: <CAEtw4r01JMFqszs0bBeeU3OXLqbT5+cU+4ZP282J3cvYzALgZg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Support xxhash64 checksums
To:     =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am Do., 22. Aug. 2019 um 16:41 Uhr schrieb Holger Hoffst=C3=A4tte
<holger@applied-asynchrony.com>:
> but how does btrfs benefit from this compared to using crc32-intel?

As i know, crc32c  is as far as ~3x faster than xxhash. But xxHash was
created with a differend design goal.
If you using a cpu without hardware crc32 support, xxHash provides you
a maximum portability and speed. Look at arm, mips, power, etc. or old
intel cpus like Core 2 Duo.
