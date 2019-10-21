Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF3A1DEE2F
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 15:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfJUNnf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 09:43:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:58228 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727322AbfJUNnf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 09:43:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C8517B155;
        Mon, 21 Oct 2019 13:43:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F3FC6DA8C5; Mon, 21 Oct 2019 15:43:46 +0200 (CEST)
Date:   Mon, 21 Oct 2019 15:43:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs-progs: add verbose option to btrfs device scan
Message-ID: <20191021134346.GL3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <1569989512-5594-1-git-send-email-anand.jain@oracle.com>
 <20191007174129.GK2751@twin.jikos.cz>
 <a9c0a957-e151-32e8-a42e-b5c6d817ed78@oracle.com>
 <20191014152457.GQ2751@twin.jikos.cz>
 <365faddf-cf4f-2a03-820d-d4f5071240e8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <365faddf-cf4f-2a03-820d-d4f5071240e8@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 15, 2019 at 11:29:34AM +0800, Anand Jain wrote:
>   I was thinking there might be some common code between the
>   sub-commands in btrfs-progs now or in future, and if the printf()
>   due to verbose is required in one sub-command and the same printf()
>   due to verbose is not required in another sub-command (which I
>   called unwanted message) then we won't have any choice to not
>   to print those unwanted printf().
>   But as this is just an anticipatory only, so probably we could try
>   global verbose and see how it fares. I will try.

I see, but it would be better to have a concrete example where it's
problematic so we can figure out ways how to filter unwanted messages.
