Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28F6C162AC5
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2020 17:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgBRQgH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Feb 2020 11:36:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:50238 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgBRQgH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Feb 2020 11:36:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 51911C1ED;
        Tue, 18 Feb 2020 16:36:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 02A42DA7BA; Tue, 18 Feb 2020 17:35:48 +0100 (CET)
Date:   Tue, 18 Feb 2020 17:35:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com, dsterba@suse.com
Subject: Re: [PATCH v5 0/5] readmirror feature (sysfs and in-memory only
 approach; with new read_policy device)
Message-ID: <20200218163547.GQ2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com, dsterba@suse.com
References: <1581937965-16569-1-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581937965-16569-1-git-send-email-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 17, 2020 at 07:12:40PM +0800, Anand Jain wrote:
> v5:
> Worked on review comments as received in its previous version.
> Please refer to individual patches for the specific changes.
> Introduces the new read_policy 'device'.

The preparatory patches look overall good, there are some minor issues.

The last patch implementing the new policy needs explanation how it
works so users can decide if this is the right read policy for the use
case.
