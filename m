Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4391A5C0C
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Apr 2020 04:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgDLCuA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 11 Apr 2020 22:50:00 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:44086 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgDLCt7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Apr 2020 22:49:59 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 370B6665A83; Sat, 11 Apr 2020 22:49:54 -0400 (EDT)
Date:   Sat, 11 Apr 2020 22:49:54 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Oliver <oliver111333777@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: cancel resize
Message-ID: <20200412024954.GQ13306@hungrycats.org>
References: <1c779cba-5d1c-0bca-38bf-af5cd572a9d0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1c779cba-5d1c-0bca-38bf-af5cd572a9d0@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 12, 2020 at 01:52:01AM +0200, Oliver wrote:
> Hello,
> 
> I've made a stupid mistake. I wanted to reduce a disk with 1990m, but
> instead resized it to 1990m.
> 
> btrfs fi resize 2:1990m /btrfs
> 
> It will take forever and might fail in the end, as I might not have enough
> space avaiable.
> 
> How do I cancel this operation ? I can see cancel operations for other
> commands, but not this one.

Currently, the only ways to stop a device shrink or remove are to run
out of space or reboot.

Patches welcome!

> thanks,
> Oliver
