Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F32FA4B5FE
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 12:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfFSKNq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 06:13:46 -0400
Received: from mail02.iobjects.de ([188.40.134.68]:46274 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfFSKNq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 06:13:46 -0400
Received: from tux.wizards.de (pD9EBFA35.dip0.t-ipconnect.de [217.235.250.53])
        by mail02.iobjects.de (Postfix) with ESMTPSA id 7AD5341651C9;
        Wed, 19 Jun 2019 12:13:44 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id 00C45EEB528;
        Wed, 19 Jun 2019 12:13:44 +0200 (CEST)
Subject: Re: updating btrfs-debugfs to python3?
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtSE2VbeGFs9o=KhPTeRGwZJ=RA2uzc3xG+sU0X-SXbRuQ@mail.gmail.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <08aa27af-8a9e-cd0c-20ab-55ce630085f4@applied-asynchrony.com>
Date:   Wed, 19 Jun 2019 12:13:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSE2VbeGFs9o=KhPTeRGwZJ=RA2uzc3xG+sU0X-SXbRuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/19/19 5:20 AM, Chris Murphy wrote:
> This is on Fedora Rawhide (which is planned to become Fedora 31 due in
> October), which no longer provides python2.
> 
> $ ./btrfs-debugfs -b /
> /usr/bin/env: ‘python2’: No such file or directory
> $
> 
> I expect other distros are going to follow as Python 2.7 EOL is coming
> up fast, in 6 months.
> https://pythonclock.org/

I just ran it through 2to3-3.7 with -w and the new version seems to work
just fine for me, so it seems there is not much porting required.

hth,
Holger
