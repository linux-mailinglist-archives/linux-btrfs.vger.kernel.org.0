Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544513C1DFF
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 06:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbhGIEIH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 00:08:07 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48466 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhGIEIG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jul 2021 00:08:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 23F1B20263;
        Fri,  9 Jul 2021 04:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625803523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4j/C6nvscC32JAPO5bQWV2jZrufIjY6+YK06V2/Jor0=;
        b=axPlcw0K/mIHQO+j6ivdbimAeXad/2eGer+d8gr9GzRCwfB5zvaf+0/EmEOOsGq6Siazbg
        p2f+YU2kHDU+UVCnLC3OS0ZVdZav0kIiTjUdnLKJEdElytCGuyKktO/RbKAqg6kKEq1r/+
        30qs6ZKyNWqUcq0fwIpkyru6vD27C0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625803523;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4j/C6nvscC32JAPO5bQWV2jZrufIjY6+YK06V2/Jor0=;
        b=OLM/eAtFcD1UPoQ9OH/P6h5nlupym8E91fX94bEmAMg1a7e80yNBdNhSAb20kNorUTE4TL
        S6urbdjG7LDDEfCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A96413B26;
        Fri,  9 Jul 2021 04:05:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1LX1MgHL52CiJAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 09 Jul 2021 04:05:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Graham Cobb" <g.btrfs@cobb.uk.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: cannot use btrfs for nfs server
In-reply-to: <56c40592-0937-060a-5f8a-969d8a88d541@cobb.uk.net>
References: <20210310074620.GA2158@tik.uni-stuttgart.de>,
 <20210311074636.GA28705@tik.uni-stuttgart.de>,
 <20210708221731.GB8249@tik.uni-stuttgart.de>,
 <56c40592-0937-060a-5f8a-969d8a88d541@cobb.uk.net>
Date:   Fri, 09 Jul 2021 14:05:16 +1000
Message-id: <162580351661.31036.9394219230568776900@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 09 Jul 2021, Graham Cobb wrote:
>=20
> > How/where can I escalate it further?
>=20
> Try complaining to NFS. It might be that it would work better if NFS
> assigned different NFS filesystem IDs to each subvolume - I don't know.
>=20
>=20
Better than complaining...:

Apply the patch you can find at

 https://lore.kernel.org/linux-nfs/162457725899.28671.14092003979067994699@no=
ble.neil.brown.name/T/#mc4752a019af79cbb166d5338d6ed0db141832546

then apply the fix described at

 https://lore.kernel.org/linux-nfs/162457725899.28671.14092003979067994699@no=
ble.neil.brown.name/T/#mc26984e10e7837e28aca3209fcb03b38a4df6fe7

which I think is shown in more detail in a subsequent message in the
thread.

Then confirm for yourself that it works.
Then reply to that thread (or send a new message to linux-nfs) saying somethi=
ng like:

 Hi,
  I've been having problems with NFS and btrfs too.  I found this patch
  and it works really well for me.  Any chance we can get it included
  upstream?=20

That might spur us on to further action - enthusiasm is much better than
complaints :-)

(the problem is not that NFS doesn't assign different filesystem IDs,
 the problem is that NFSd doesn't tell NFS that there are different volumes).

NeilBrown
