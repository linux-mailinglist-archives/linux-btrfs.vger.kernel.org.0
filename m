Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B21C8E02F5
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 13:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388690AbfJVLdr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 07:33:47 -0400
Received: from rin.romanrm.net ([91.121.75.85]:44350 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387768AbfJVLdr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 07:33:47 -0400
Received: from natsu (natsu.2.romanrm.net [IPv6:fd39:aa:7359:7f90:e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 2CA9C20276;
        Tue, 22 Oct 2019 11:33:44 +0000 (UTC)
Date:   Tue, 22 Oct 2019 16:33:44 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: feature request, explicit mount and unmount kernel messages
Message-ID: <20191022163344.19122329@natsu>
In-Reply-To: <CAJCQCtTPAm6eGA80y9LYc+Jaeo1wB0+vOMvO6B02o5JJKRFrhw@mail.gmail.com>
References: <CAJCQCtTPAm6eGA80y9LYc+Jaeo1wB0+vOMvO6B02o5JJKRFrhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 22 Oct 2019 11:00:07 +0200
Chris Murphy <lists@colorremedies.com> wrote:

> Hi,
> 
> So XFS has these
> 
> [49621.415203] XFS (loop0): Mounting V5 Filesystem
> [49621.444458] XFS (loop0): Ending clean mount
> ...
> [49621.444458] XFS (loop0): Ending clean mount
> [49641.459463] XFS (loop0): Unmounting Filesystem
> 
> It seems to me linguistically those last two should be reversed, but whatever.

Just a minor note, there is no "last two", but only one "Unmounting" message
on unmount: you copied the "Ending" mount-time message twice for the 2nd quote
(as shown by the timestamp).

-- 
With respect,
Roman
