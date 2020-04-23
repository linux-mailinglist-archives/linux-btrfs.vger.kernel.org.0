Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C121B54D4
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Apr 2020 08:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgDWGp2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Apr 2020 02:45:28 -0400
Received: from lists.nic.cz ([217.31.204.67]:48052 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgDWGp2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Apr 2020 02:45:28 -0400
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id 538E1141357;
        Thu, 23 Apr 2020 08:45:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1587624326; bh=/PcD3tg0VT8rpqDZb/DwBImC7BKWUEdivatN5l55dL4=;
        h=Date:From:To;
        b=EF9zwzXpX/AVephQXga0Hn40K02c3RbmGt1ISn4D9RWVamksZ6AEs1aQYB+jQ1pPR
         RGEsEzlMG1RVoKtxMF/URHqZn2oOtaHiyAlP85QkJS/RCykt18mTJcTTzDefm51QuV
         G3+ZniRhbDIIwakeAMf7qIsgm0eeY+6gvoUvui8E=
Date:   Thu, 23 Apr 2020 08:45:25 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: when does btrfs create sparse extents?
Message-ID: <20200423084525.6885e978@nic.cz>
In-Reply-To: <9f96fe0c-cbe5-12c8-67f5-2981c9273c5d@gmail.com>
References: <20200422205209.0e2efd53@nic.cz>
        <9f96fe0c-cbe5-12c8-67f5-2981c9273c5d@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,
        USER_IN_WHITELIST shortcircuit=ham autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 23 Apr 2020 08:57:59 +0300
Andrei Borzenkov <arvidjaar@gmail.com> wrote:

> 22.04.2020 21:52, Marek Behun =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Hello,
> >=20
> > there was a bug fixed recently in U-Boot's btrfs driver - the driver
> > failed to read files with sparse extents. This causes that sometimes
> > device failes to boot Linux, since the kernel fails to load from
> > storage.
> >  =20
>=20
> Do you mean that kernel image (vmlinuz?) had holes? Or there were some
> other files that caused U-Boot to fail?

Kernel image (non-compressed Image for arm64) had ~200 PAGE_SIZEd
all-zero blocks.
