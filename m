Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76405DB063
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 16:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502982AbfJQOrh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 10:47:37 -0400
Received: from smtp1.rz.tu-harburg.de ([134.28.205.38]:57060 "EHLO
        smtp1.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502979AbfJQOrg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 10:47:36 -0400
Received: from mail.tu-harburg.de (mail4.rz.tu-harburg.de [134.28.202.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.tuhh.de", Issuer "DFN-Verein Global Issuing CA" (verified OK))
        by smtp1.rz.tu-harburg.de (Postfix) with ESMTPS id 46vBpY22yyzxWM;
        Thu, 17 Oct 2019 16:47:33 +0200 (CEST)
Received: from mailspring.rz.tuhh.de (mailspring.rz.tuhh.de [134.28.202.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cmz7792@KERBEROS.TU-HARBURG.DE)
        by mail.tu-harburg.de (Postfix) with ESMTPSA id 46vBpX6ZFPzJrC3;
        Thu, 17 Oct 2019 16:47:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuhh.de; s=x2019-42;
        t=1571323653; bh=k3T1G76NElcRxsx3LCnAWPCxtIF//uXAJmOiR7sOcls=;
        h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type:Content-Transfer-Encoding;
        b=XEz1aOF5bPQnTNoDVGbQoIqJnlYuDwfjoggXPOqnotv8siUQKDD5mvtED38S+ExXB
         vrUJTH7t7cqC1XJOo00We15cvEtTl1YhkYdVL5FEQURIecany8SkeHrTC7fbHPTqZP
         OCbnYuFYxfhazsFVT/CiutMPNYc7wY1915xMs6b0=
Date:   Thu, 17 Oct 2019 16:47:31 +0200
From:   Merlin =?UTF-8?B?QsO8Z2U=?= <merlin.buege@tuhh.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: small fixes/cleanup in Documentation
Message-ID: <20191017164731.48111095.merlin.buege@tuhh.de>
In-Reply-To: <20191017111805.GE2751@twin.jikos.cz>
References: <20191017045006.130378-1-merlin.buege@tuhh.de>
        <1201273d-8051-b65a-51bc-6e4c12cff7f2@suse.com>
        <20191017111805.GE2751@twin.jikos.cz>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Thu, 17 Oct 2019 13:18:05 +0200
David Sterba <dsterba@suse.cz> wrote:

> Well, for documentation patches and for progs it's not that strict and
> I've applied many drive-by patches. My sign-off will be there and the
> original author is usually mentioned as Author:, so the credit is
> recorded.

I'm fine with that.

Sorry, I'm not yet really familiar with the email driven patch workflow
(actually it's my first patch via email). I will include a SOB line
next time. If I should resend this patch with one, please tell me!

Q: How would I go about updating the patch? Just completely resend it
to the mailing list from scratch so a new thread gets created, or
replying to the existing one?

@David: Sorry for double posting.

Thanks.
--=20
Merlin B=C3=BCge
