Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C071E1CC103
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 May 2020 13:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgEILfg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 May 2020 07:35:36 -0400
Received: from bang.steev.me.uk ([81.2.120.65]:44557 "EHLO smtp.steev.me.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgEILfg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 9 May 2020 07:35:36 -0400
X-Greylist: delayed 1460 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 May 2020 07:35:35 EDT
Received: from localhost ([::1] helo=webmail.steev.me.uk)
        by smtp.steev.me.uk with esmtp (Exim 4.92.3)
        id 1jXNNy-007uB1-Sb
        for linux-btrfs@vger.kernel.org; Sat, 09 May 2020 12:11:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 09 May 2020 12:11:14 +0100
From:   Steven Davies <btrfs-list@steev.me.uk>
To:     linux-btrfs@vger.kernel.org
Subject: Exploring referenced extents
Message-ID: <c9a53b726880c5d7dc8092c2078e23a5@steev.me.uk>
X-Sender: btrfs-list@steev.me.uk
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For curiosity I'm trying to write a tool which will show me the size of 
data extents belonging to which files in a snapshot are exclusive to 
that snapshot as a way to show how much space would be freed if the 
snapshot were to be deleted, and which files in the snapshot are taking 
up the most space.

I'm working with Hans van Kranenburg's python-btrfs python library but 
my knowledge of the filesystem structures isn't good enough to allow me 
to figure out which bits of data I need to be able to achieve this. I'd 
be grateful if anyone could help me along with this.

So far my idea is:

for each OS file in a subvolume:
   find its data extents
   for each extent:
     find what files reference it #1
     for each referencing file:
       determine which subvolumes it lives in #2
     if all references are within this subvolume:
       record the OS file path and extents it references

for each recorded file path
   find its data extents
   output its path and the total number of bytes in all recorded extents 
(those which are not shared)

#1 and #2 are where my understanding breaks down. How do I find which 
files reference an extent and which subvolume those files are in?

Alternatively, if such a script already exists I would be happy to use 
it.

Thanks for any pointers.
-- 
Steven Davies
