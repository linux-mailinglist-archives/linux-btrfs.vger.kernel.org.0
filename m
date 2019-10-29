Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 190B3E89FF
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2019 14:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388871AbfJ2Nvt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Oct 2019 09:51:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:56786 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388453AbfJ2Nvt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Oct 2019 09:51:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 101FCB44B;
        Tue, 29 Oct 2019 13:51:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EFC00DA734; Tue, 29 Oct 2019 14:51:57 +0100 (CET)
Date:   Tue, 29 Oct 2019 14:51:57 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        dsterba@suse.com, linux-btrfs@vger.kernel.org, mpdesouza@suse.com
Subject: Re: [PATCH devel] btrfs-progs: subvolume: Implement delete
 --subvolid <path>
Message-ID: <20191029135157.GU3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        dsterba@suse.com, linux-btrfs@vger.kernel.org, mpdesouza@suse.com
References: <20191028160506.22245-1-marcos.souza.org@gmail.com>
 <cb24c0bb-121e-08bc-9138-16abb1f2727a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb24c0bb-121e-08bc-9138-16abb1f2727a@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 29, 2019 at 10:05:25AM +0800, Anand Jain wrote:
> > @@ -223,6 +223,7 @@ static int wait_for_commit(int fd)
> >   
> >   static const char * const cmd_subvol_delete_usage[] = {
> >   	"btrfs subvolume delete [options] <subvolume> [<subvolume>...]",
> > +	"btrfs subvolume delete [options] [--subvolid <subvolid> <path>]",
> 
> 
> It should rather be..
> 
> + "btrfs subvolume delete [options] <[-s|--subvolid <subvolid> <path>] | 
> [<subvolume>...]>"

This is hard to understand on the first read, so the preferred way is to
split into more lines when an option changes the overall behaviour, eg.
what plain receive and receive --dump does:


$ ./btrfs receive --help
usage: btrfs receive [options] <mount>
       btrfs receive --dump [options]
