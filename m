Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB7413C24A
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 14:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgAONKp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 08:10:45 -0500
Received: from mail.itouring.de ([188.40.134.68]:35730 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbgAONKp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 08:10:45 -0500
Received: from tux.applied-asynchrony.com (p5B07E981.dip0.t-ipconnect.de [91.7.233.129])
        by mail.itouring.de (Postfix) with ESMTPSA id 6053A416A139
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2020 14:10:43 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 13413F01607
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2020 14:10:43 +0100 (CET)
Subject: Re: Scrub resume regression
To:     linux-btrfs@vger.kernel.org
References: <d0a97688-78be-08de-ca7d-bcb4c7fb397e@cobb.uk.net>
 <20200115125134.GN3929@twin.jikos.cz>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <5aa23833-d1e2-fe6f-7c6e-f366d3eccbe3@applied-asynchrony.com>
Date:   Wed, 15 Jan 2020 14:10:42 +0100
MIME-Version: 1.0
In-Reply-To: <20200115125134.GN3929@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/15/20 1:51 PM, David Sterba wrote:
>> It is important that scrub always returns the stats, even when it
>> returns an error. This is critical for cancel, as that is how
>> cancel/resume works, but it should also apply in case of other errors so
>> that the user can see how much of the scrub was done before the fatal error.
> 
> That's something we need to document in code and perhaps in the manual
> pages too.

Isn't the real problem that cancel does not actually mean cancel,
but rather also implies "..and maybe continue"? IMHO cancel should cancel
(and say how much work was performed), while the intention to resume should
be called e.g. "pause". This makes the behaviour clear and prevents
accidental semantic overlap.

-h
