Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B0343B828
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Oct 2021 19:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbhJZRal convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 26 Oct 2021 13:30:41 -0400
Received: from rx2.rx-server.de ([45.9.62.189]:55880 "EHLO rx2.rx-server.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237794AbhJZRak (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Oct 2021 13:30:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by rx2.rx-server.de (Postfix) with ESMTP id D60C943D4C;
        Tue, 26 Oct 2021 19:28:14 +0200 (CEST)
X-Spam-Flag: NO
X-Spam-Score: -2.402
X-Spam-Level: 
X-Spam-Status: No, score=-2.402 required=5 tests=[BAYES_00=-1.9,
        FROM_IS_REPLY_TO=-0.5, NO_RECEIVED=-0.001, NO_RELAYS=-0.001]
        autolearn=ham autolearn_force=no
Received: from rx2.rx-server.de ([127.0.0.1])
        by localhost (rx2.rx-server.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6biAZypEAKfu; Tue, 26 Oct 2021 19:28:14 +0200 (CEST)
X-Original-To: patrik.lundquist@gmail.com
X-Original-To: quwenruo.btrfs@gmx.com
X-Original-To: linux-btrfs@vger.kernel.org
From:   Mia <9speysdx24@kr33.de>
To:     "Patrik Lundquist" <patrik.lundquist@gmail.com>,
        "Qu Wenruo" <quwenruo.btrfs@gmx.com>
Subject: Re: filesystem corrupt - error -117
Cc:     "Linux Btrfs" <linux-btrfs@vger.kernel.org>
Date:   Tue, 26 Oct 2021 17:28:14 +0000
Message-Id: <emb611c0ff-705d-4c01-b50f-320f962f39fb@rx2.rx-server.de>
In-Reply-To: <CAA7pwKOrgt6syr5C3X1+bC14QXZEJ+8HTMZruBBPBT574zNkkQ@rx2.rx-server.de>
References: <em969af203-04e6-4eff-a115-1129ae853867@frystation>
 <em33e101b0-d634-48b5-8a32-45e295f48f16@rx2.rx-server.de>
 <c2941415-e32f-b31d-0bc2-911ede3717b7@gmx.com>
 <69109d24-efa7-b9d1-e1df-c79b3989e7bf@rx2.rx-server.de>
 <em0473d04b-06b0-43aa-91d6-1b0298103701@rx2.rx-server.de>
 <146cff2c-3081-7d03-04c8-4cc2b4ef6ff1@suse.com>
 <884d76d1-5836-9a91-a39b-41c37441e020@rx2.rx-server.de>
 <em6e5eb690-6dcd-482d-b4f2-1b940b6cb770@rx2.rx-server.de>
 <3ce1dd17-b574-abe3-d6cc-eb16f00117cc@rx2.rx-server.de>
 <em2512c4e9-1e5e-4aa0-b9fc-fb68891e615d@rx2.rx-server.de>
 <CAA7pwKOrgt6syr5C3X1+bC14QXZEJ+8HTMZruBBPBT574zNkkQ@rx2.rx-server.de>
Reply-To: Mia <9speysdx24@kr33.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Patrik,

good suggestion, I'm on 5.10.0-0.bpo.8-amd64 #1 SMP Debian 
5.10.46-4~bpo10+1 (2021-08-07) now.

Hi Qu,
regarding the memtest. This is a virtual machine, I have no access to 
the host system.
I don't know if a memtest inside the vm would bring legit results?

Regards
Mia

------ Originalnachricht ------
Von: "Patrik Lundquist" <patrik.lundquist@gmail.com>
An: "Mia" <9speysdx24@kr33.de>
Cc: "Linux Btrfs" <linux-btrfs@vger.kernel.org>
Gesendet: 26.10.2021 16:12:45
Betreff: Re: filesystem corrupt - error -117

>On Tue, 26 Oct 2021 at 09:15, Mia <9speysdx24@kr33.de> wrote:
>>
>>  Problem with updating is that this is currently still Debian 10 and a
>>  production environment and I don't know when it is possible to upgrade
>>  because of dependencies.
>
>Maybe you can install the buster-backports kernel which currently is 5.10.70?
>
>https://backports.debian.org/Instructions/

