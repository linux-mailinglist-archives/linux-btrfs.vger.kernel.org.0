Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7342019EA37
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Apr 2020 11:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgDEJpE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Apr 2020 05:45:04 -0400
Received: from ciao.gmane.io ([159.69.161.202]:54864 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgDEJpD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Apr 2020 05:45:03 -0400
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcfb-btrfs-devel-moved1-3@m.gmane-mx.org>)
        id 1jL1pu-000SEg-Cv
        for linux-btrfs@vger.kernel.org; Sun, 05 Apr 2020 11:45:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-btrfs@vger.kernel.org
From:   Achim Gratz <Stromeko@nexgo.de>
Subject: Re: My first attempt to use btrfs failed miserably
Date:   Mon, 03 Feb 2020 20:14:47 +0100
Organization: Linux Private Site
Message-ID: <87o8uffpp4.fsf@Rainer.invalid>
References: <CACN+yT_AYiLc29M41U+WrQHtk4t==D-4AkH+wRROKJY=WstGAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Cancel-Lock: sha1:xvrvQqf0ltMXRBy4PSeUwL0VOyw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Skibbi writes:
> So I decided to try btrfs on my new portable WD Password Drive
> attached to Raspberry Pi 4.

That's an actual harddisk that likely pulls a lot of peak current, just
under the limit allowed by the USB standard.  You are begging for
trouble connecting that to the rasPi without an extra PSU for the drive.
I don't have that exact model here, but if you can feed external power
into the drive, do it.  Second, the rasPi4 itself is a bit of a power
hog, so you will need a stable power supply there as well (250mV of
overvoltage don't hurt either), even when the drive doesn't draw current
from the USB port.  The annoying thing with drives on USB is that they
may well seem to be OK if you didn't specifically look for
disconnect/reconnect events, but each time it happens that data is most
likely lost anyway.  Btrfs just tells you sooner than some other fs.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Samples for the Waldorf Blofeld:
http://Synth.Stromeko.net/Downloads.html#BlofeldSamplesExtra

