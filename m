Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C49221357BF
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 12:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbgAILQv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 06:16:51 -0500
Received: from mail.itouring.de ([188.40.134.68]:45044 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728918AbgAILQv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jan 2020 06:16:51 -0500
Received: from tux.applied-asynchrony.com (p5B07E981.dip0.t-ipconnect.de [91.7.233.129])
        by mail.itouring.de (Postfix) with ESMTPSA id B9B0D416D37E;
        Thu,  9 Jan 2020 12:16:49 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 797AAF015C3;
        Thu,  9 Jan 2020 12:16:49 +0100 (CET)
Subject: Re: btrfs scrub: cancel + resume not resuming?
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
To:     Graham Cobb <g.btrfs@cobb.uk.net>,
        =?UTF-8?Q?Sebastian_D=c3=b6ring?= <moralapostel@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CADkZQakAhrRHFeHPJfne5oLT81qFGbzNAiUoqb3r0cxVSuHTNg@mail.gmail.com>
 <b031f351-2a9c-83b3-7e4b-ac15791d96e6@applied-asynchrony.com>
 <71add409-04ad-c6be-4f4f-5eec4ffb167c@cobb.uk.net>
 <bafe1610-914b-c9b4-3f04-a0fdcc97d256@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <5a54869e-e268-2423-3a51-a8752d355c92@applied-asynchrony.com>
Date:   Thu, 9 Jan 2020 12:16:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <bafe1610-914b-c9b4-3f04-a0fdcc97d256@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/9/20 12:05 PM, Holger Hoffstätte wrote:
> $cat test-scrub
> #!/bin/sh
> btrfs scrub start /mnt/backup
> sleep 30
> btrfs scrub status -R /mnt/backup
> btrfs scrub cancel /mnt/backup
> btrfs scrub resume /mnt/backup
> sleep 10
> btrfs scrub status -R /mnt/backup
> 
[snip]
>      last_physical: 3591372800
>          ^^^^^^^^^^^^^^^^^^^^^^^^^
[snip]
>      last_physical: 923205632
>          ^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Not sure what I'm doing wrong ;)

AARGH. What I'm doing wrong is that I can't read and that it indeed seems
to start from the beginning. Nice catch!

-h
