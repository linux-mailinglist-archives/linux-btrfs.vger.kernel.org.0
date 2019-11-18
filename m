Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A504B100D4D
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 21:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfKRUuO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 15:50:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:49058 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726666AbfKRUuO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 15:50:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 82BF9B13D;
        Mon, 18 Nov 2019 20:50:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E9A08DAB3A; Mon, 18 Nov 2019 21:50:13 +0100 (CET)
Date:   Mon, 18 Nov 2019 21:50:13 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     linux-kernel@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org, mpdesouza@suse.com
Subject: Re: [PATCH 0/5] btrfs: send uevent on subvolume add/remove
Message-ID: <20191118205013.GO3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org, mpdesouza@suse.com
References: <20191024023636.21124-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024023636.21124-1-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 23, 2019 at 11:36:31PM -0300, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Hey guys,
> 
> these patches make btrfs to send an uevent to userspace whenever a subvolume is
> added/removed. The changes are pretty straightforward. This patchset was based
> in btrfs-misc-next.
> 
> The first patch adds an additional argument to btrfs_kobject_uevent to receive a
> envp, and just forward this argument to kobject_uevent_envp.

For the reference, this is from the project ideas on wiki
https://btrfs.wiki.kernel.org/index.php/Project_ideas#Send_notifications_about_important_events

There are 2 parts, the "transport" and the events. The device uevents
mechanism is the transport, so all we need here is to extend the
environment pointer with the data. AFAICS, this itself builds on netlink
so there are more possible consumers of the events, namely not just udev
and the like.

The events is more high-level thing and the wiki lists some of them. You
picked the subvolume creation/deletion, which is fine for demonstration
and prototyping. Right now the details of the events need to be defined.

> Patch number 2 creates a new function that will be called by patches 4 and 5 to
> setup the environment variable to be set to userspace using uevent. These two
> environment variables are BTRFS_VOL_{NEW,DEL} and BTRFS_VOL_NAME. The first
> variable will have the value 1 for subvolume add/remove (only one will be
> exported, so udev can distinguish the event), and the second one hold the name
> of the subvolume being added/removed.
> 
> Feel free to suggest any other useful information to be exported to userspace
> when adding/removing a subvolume.

The filesystem id needs to be there, maybe for all events. For the
subvolume in particular there can be the id, parent id and flags. We
need to see and forsee all the events and identify the common event
data, or for same group events (like device manipulation) and decide if
we go specific event "types" for each action. I think something that
follows the naming and granularity of ioctls would be least confusing.

So for subvolumes we can start with SUBVOLUME_CREATE and
SUBVOLUME_DESTROY.
