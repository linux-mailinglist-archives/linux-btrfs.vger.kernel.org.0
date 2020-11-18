Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23EE2B73A6
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 02:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgKRBRk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Nov 2020 20:17:40 -0500
Received: from mx.kolabnow.com ([95.128.36.40]:15894 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgKRBRj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Nov 2020 20:17:39 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 20514C4A;
        Wed, 18 Nov 2020 02:17:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        references:message-id:content-transfer-encoding:date:date
        :in-reply-to:from:from:subject:subject:mime-version:content-type
        :content-type:received:received:received; s=dkim20160331; t=
        1605662257; x=1607476658; bh=SwgILzUZv7IpBwZTVYk54liC8DzOz/nPnGJ
        LJrKp6JM=; b=DEs/IzsDdhRsmJLTpeXFnOdh6Se2H/NfEWH+KhF4PNJ+VGVvERs
        IwiwQ//WShzOOZgkb8ZoU/KW34ry5aTmbQt1cgMBRblMyYQijG00Jl0lNr7s0vZ4
        +A5R2l1JvuowLmOy3HxZ9Qbcdh9GHLCJjKaE3/F4EH4sLX0e7g4F76hfrEmZ9Pni
        KnBTw5SYxDrJqI41t0TIF3YFssaIU1GNXMPcpHAspJ8cNpLsxl4pJ0/Zkv3p8TdM
        k2Xmy6aOwgRAX5aisiEKxPEBcN8ykyDvPZO4/uXYOAlWdJBg8w9M4FRIH+RFZ4/q
        3EVXEwMFe2eUHWp9eYNITgqzQmaEDGrmkmcDHsqAFbRfkEczGEY5bIjdIgxf6wpA
        wrAvCb7/hfrCw57jFgDQfmrAst3r3wNIW47B92tHs03ULw4E7LR96Qy5mETvQc20
        WPELSL+5EzAUP1OlWHvDwdhbcFbSFYEThDhGsDxcRfbOrrAkDPQKIS+W1XJZbhlC
        +YkUvimFD5PHixSpg+DLUJAqVdHfX/7o6H6/VVyPenpycBNn+fwEJC/FIur/469f
        m3ZD1Ffgq3yOD/RuVbI+dYBz/zBn9DEc7BYRJoD9d2gtNsbn/vjyeKKIQ/eMkXev
        JYVd0RF3xJbB6v5DnvoDZZtZJ7BLtSkRZNksddfGcE0l07f3mkhcuJfU=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 tagged_above=-10 required=5
        tests=[BAYES_00=-1.9, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id A-rHPcru55o3; Wed, 18 Nov 2020 02:17:37 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 83363A6D;
        Wed, 18 Nov 2020 02:17:37 +0100 (CET)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 18B23210D;
        Wed, 18 Nov 2020 02:17:37 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.13\))
Subject: Re: bizare bug in "btrfs subvolume show"
From:   Lawrence D'Anna <larry@elder-gods.org>
In-Reply-To: <3612C07A-0872-401F-89D9-E9DFA9C9D0C6@elder-gods.org>
Date:   Tue, 17 Nov 2020 17:17:31 -0800
Cc:     Roman Mamedov <rm@romanrm.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Meghan Gwyer <mgwyer@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <57831452-9DB1-4CDA-B6FD-75BFACF48C2E@elder-gods.org>
References: <61E331A6-9DA8-4A7C-905E-4B5A17526020@elder-gods.org>
 <8EFE06A3-9CC4-4A6A-850F-C7C57DC27942@elder-gods.org>
 <20201115145323.1628d710@natsu>
 <C20FAB48-98B0-49AE-B804-FC720E31C5B0@elder-gods.org>
 <e954d760-28c1-9491-cd60-8e7dfc626ca4@libero.it>
 <3612C07A-0872-401F-89D9-E9DFA9C9D0C6@elder-gods.org>
To:     kreijack@inwind.it
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


I tried this ubuntu mainline build, and the problem went away :/=20

https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.9.8/

Linux odin 5.9.8-050908-generic #202011101634 SMP Wed Nov 11 00:51:04 =
UTC 2020 x86_64 x86_64 x86_64 GNU/Linux

