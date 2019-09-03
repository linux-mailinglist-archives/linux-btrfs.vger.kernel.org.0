Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02ECEA63AD
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2019 10:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfICIRI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Sep 2019 04:17:08 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:39476 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbfICIRI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Sep 2019 04:17:08 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1i53zs-0001pP-GI; Tue, 03 Sep 2019 10:17:04 +0200
Date:   Tue, 3 Sep 2019 10:17:04 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: docbook45 is gone
Message-ID: <20190903081704.GA6277@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!
I'm afraid that asciidoctor 2.0 dropped support for docbook45.  The
explanation given is here:
https://github.com/asciidoctor/asciidoctor/issues/3005

This makes btrfs-progs fail to build unless docs are off, with:
asciidoctor: FAILED: missing converter for backend 'docbook45'. Processing aborted.

Naively bumping the backend to docbook5 makes the output fail to pass
validation.

I don't know a thing about docbook nor asciidoc, thus I can't fix this
myself.  kdave: you did the conversion, could you save us now?


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢠⠒⠀⣿⡁ Ivan was a worldly man: born in St. Petersburg, raised in
⢿⡄⠘⠷⠚⠋⠀ Petrograd, lived most of his life in Leningrad, then returned
⠈⠳⣄⠀⠀⠀⠀ to the city of his birth to die.
