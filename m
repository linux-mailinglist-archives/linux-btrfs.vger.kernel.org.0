Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73B0498F5F
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jan 2022 20:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351591AbiAXTwJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jan 2022 14:52:09 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58300 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356915AbiAXTrj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jan 2022 14:47:39 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6F7FE21999;
        Mon, 24 Jan 2022 19:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643053350;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uk4yJXt5bU5Zj9U01tGsXKXIzarJNnJJ/xFI3TIiBoM=;
        b=xkY7eOJES7BjCHlJTRH4JbxrgF0LCTKv9dKbQ5tYUEV7xi9y5DhEe7zPQB9rTUt/NIPSO9
        PVQafygGeXO7H00IegrAnUcU+suZJNHlIrOxinCx0Lm+rzGk63VNtyA2ak9g0vVkJTaOna
        81ymFH75eNw3z05/SzbEfGjtmlwG/Js=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643053350;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uk4yJXt5bU5Zj9U01tGsXKXIzarJNnJJ/xFI3TIiBoM=;
        b=eJRB+hsY11bzgiBAkX8cKR7FV7wgFKY7T/JEljfNT1Ec4pmQ7cSuLnZ7IK2M912KE84sy/
        DxF9d/DTurpNl9Ag==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 57883A3BF6;
        Mon, 24 Jan 2022 19:42:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 44F7EDA7A3; Mon, 24 Jan 2022 20:41:50 +0100 (CET)
Date:   Mon, 24 Jan 2022 20:41:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2] btrfs: zoned: Remove redundant initialization of
 to_add
Message-ID: <20220124194149.GD14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220121114351.93220-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121114351.93220-1-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 21, 2022 at 07:43:51PM +0800, Jiapeng Chong wrote:
> to_add is being initialized to len but this is never read as
> to_add is overwritten later on. Remove the redundant
> initialization.
> 
> Cleans up the following clang-analyzer warning:
> 
> fs/btrfs/extent-tree.c:2769:8: warning: Value stored to 'to_add' during
> its initialization is never read [clang-analyzer-deadcode.DeadStores].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Added to misc-next, thanks.
