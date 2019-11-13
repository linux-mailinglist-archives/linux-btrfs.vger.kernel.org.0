Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C71E0FACEF
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 10:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfKMJ2n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 04:28:43 -0500
Received: from mail-40132.protonmail.ch ([185.70.40.132]:40390 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfKMJ2n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 04:28:43 -0500
Date:   Wed, 13 Nov 2019 09:28:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fomin.one;
        s=protonmail; t=1573637320;
        bh=caZztISJc5fh7ieokzFP9qo1B1CbqmENz8b/jEvP5ZE=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:Feedback-ID:
         From;
        b=HPH+g7ruwW+aEah4Kybp5ztAiOIhwF34I64oDUiBMmpr1QhfaGtYbX7SPpaSwFl5e
         GELrVut54jvXDPsu9dIdZCnGzw9CVNgS+uloicx9dsBAlcVSEdsw2t6Z8UkqCHqhuW
         uGFAl4sFfwW+5I1D7T6ddYKOow4f064kktHqFAcc=
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Maksim Fomin <maxim@fomin.one>
Reply-To: Maksim Fomin <maxim@fomin.one>
Subject: Potential CVE due to malicious UUID conflict?
Message-ID: <qs_-w114I5p8c1eRnhwyZXxnP_XFxfWGIFw1rTBNwxQOzjq7d0EiJoEgHX8jVDDLtze2SNcRe55qT6mxV6ZVYvNNsm2ZyHkopl20UX9VY-0=@fomin.one>
In-Reply-To: <1204250219.669.1573609035591.JavaMail.zimbra@raptorengineeringinc.com>
References: <1204250219.669.1573609035591.JavaMail.zimbra@raptorengineeringinc.com>
Feedback-ID: KdoJEVg5m21Zx-ZSt0YICttvNlCPIx4ISbXx_ujMcsAL9BeL-sYmJMAlEoWM-R55KO6tZ96oLFF00uPgMM7IOA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Wednesday, 13 November 2019 =D0=B3., 4:37, Timothy Pearson <tpearson@rap=
torengineering.com> wrote:

> I was recently informed on #btrfs that simply attaching a device with the=
 same UUID as an active BTRFS filesystem to a system would cause silent cor=
ruption of the active disk.

BTRFS has two UUIDs: the "UUID" and "UUID_SUB".

> Two questions, since this seems like a fairly serious and potentially CVE=
-worthy bug (trivial case would seem to be a USB thumbdrive with a purposef=
ul UUID collision used to quietly corrupt data on a system that is otherwis=
e secured):

Are you from security area? These people seem to be desperate in finding re=
al security holes so they try to present any software error as a CVE. For e=
xample, they tried to present initrd pass through to root console [1] or sy=
stemd lauching a service with root permissions as a CVE [2]. Regarding this=
 btrfs uuid issue - the data will be silently corrupted, but this "CVE" wou=
ld require physical access to machine (like in initrd case). Besides, this =
issue is known for a long time. Bad news, no one will earn a CVE badge for =
reporting this issue. Security trolls should find hope somewhere else.

[1] https://www.cvedetails.com/cve/CVE-2016-4484/

[2] https://www.securityweek.com/linux-systemd-gives-root-privileges-invali=
d-usernames
