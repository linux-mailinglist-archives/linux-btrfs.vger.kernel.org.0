Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B79919EA39
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Apr 2020 11:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgDEJuE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Apr 2020 05:50:04 -0400
Received: from ciao.gmane.io ([159.69.161.202]:41490 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbgDEJuE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Apr 2020 05:50:04 -0400
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcfb-btrfs-devel-moved1-3@m.gmane-mx.org>)
        id 1jL1uj-000Xwd-UL
        for linux-btrfs@vger.kernel.org; Sun, 05 Apr 2020 11:50:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-btrfs@vger.kernel.org
From:   Achim Gratz <Stromeko@nexgo.de>
Subject: Re: [RFC][PATCH v2] btrfs: ssd_metadata: storing metadata on SSD
Date:   Sun, 05 Apr 2020 10:22:00 +0200
Organization: Linux Private Site
Message-ID: <87o8s6bavr.fsf@Rainer.invalid>
References: <20200405071943.6902-1-kreijack@libero.it>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Cancel-Lock: sha1:SecahP3oVHNeYF4iZYzd3y+EJHE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Goffredo Baroncelli writes:
> This is an RFC; I wrote this patch because I find the idea interesting
> even though it adds more complication to the chunk allocator.
>
> The core idea is to store the metadata on the ssd and to leave the data
> on the rotational disks. BTRFS looks at the rotational flags to
> understand the kind of disks.

My comment really is only about his aspect of your proposal: I would
consider a more general way of introducing a tiering of disks so that
one can discern between slower and faster SSD as well.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Factory and User Sound Singles for Waldorf rackAttack:
http://Synth.Stromeko.net/Downloads.html#WaldorfSounds

