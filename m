Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA06C3239EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Feb 2021 10:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbhBXJw0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Feb 2021 04:52:26 -0500
Received: from mail02.aqueos.net ([94.125.164.151]:27932 "EHLO
        mail02.aqueos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbhBXJwC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Feb 2021 04:52:02 -0500
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Feb 2021 04:52:01 EST
Received: from localhost (localhost [127.0.0.1])
        by mail02.aqueos.net (Postfix) with ESMTP id 60C0A1A0CDB
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Feb 2021 10:43:08 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail02.aqueos.net
Received: from mail02.aqueos.net ([127.0.0.1])
        by localhost (mail02.aqueos.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id T2vxWAI3Xo7r for <linux-btrfs@vger.kernel.org>;
        Wed, 24 Feb 2021 10:43:07 +0100 (CET)
Received: from [10.10.10.10] (adsl2.aqueos.com [185.63.172.127])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail02.aqueos.net (Postfix) with ESMTPSA id 9180B1A0CCA
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Feb 2021 10:43:07 +0100 (CET)
To:     linux-btrfs@vger.kernel.org
From:   Ghislain Adnet <gadnet@aqueos.com>
Subject: btrfd, is btrfs daemon a thing ?
Organization: AQUEOS
Message-ID: <900f07e8-251f-de6f-1fcf-0168ca3ad72d@aqueos.com>
Date:   Wed, 24 Feb 2021 10:43:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

hi there,

  As a newbie in Btrfs land i installed a raid1 configuration and played with it.
  After hot removing a drive of the raid i got two remarks that i cannot find answer with with my google foo.

  So, to not die stupid i post a little email here to see if there is solutions about this :)

   The experiment finished well the raid was reconstructed ans some untouched partition were even recreated automaticaly when the drive was put back, this is very cool !
   The one with changes had to be manualy replaced, that was espected.

   The issues are:

- logs: my systemd journal and my kernel.log were completely stampeded by btrfs logs.
        On the mdadm world you have some message about disapearing drives and then it stops.
        On my test there was hundreds of megabytes of brtfs error logs.

- monitoring : on mdamd you have a daemon that can warn you and even automaticaly run programs to warn you of a failure.
                I think zfs has this too with ZED.
                I was not able to find such a thing in btrfs.
                Does it exist such a monitoring system capable of warning the admin when error appear in btrfs other than cron grepping the logs or btrfs device stats ?


   Is there anyway to mitigate the log issue and did someone took a shot at a monitoring system for btrfs ?

--
best regards,
Ghislain.
