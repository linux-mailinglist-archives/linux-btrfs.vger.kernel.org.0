Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E7C3C7EC9
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 08:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238110AbhGNG5Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 02:57:16 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34802 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237948AbhGNG5P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 02:57:15 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 800092298F;
        Wed, 14 Jul 2021 06:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626245663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UnjJ0RyrICTfPpHXMRjxbALg8wKEcDNN4mlAoqPhX0w=;
        b=t2KdNdm7dujKhgb0o6mwQ3d0GeY7jUDmrISDM3lymVRDSKP6xSNqutyccwRF6iIH3cAbSF
        0uAdngCluZCGlbBDjtOwr9Krpet1Mn3KfIUi3jRpZRIRjeBVIFxLBy+jBivWoDaSpl3qaT
        I2AJ+w+GbQVcQKHdsBVYBRhHwRIKNNM=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 4105013A67;
        Wed, 14 Jul 2021 06:54:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id OFKjCh+K7mAdXgAAGKfGzw
        (envelope-from <nborisov@suse.com>); Wed, 14 Jul 2021 06:54:23 +0000
Subject: Re: [PATCH] btrfs-progs: doc: fix the out-of-date contents on
 btrfs-progs support on free space cache tree
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210714061114.189575-1-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <3c5c5cca-fe5a-b6ce-cf2b-b1e8f9cc2bc9@suse.com>
Date:   Wed, 14 Jul 2021 09:54:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714061114.189575-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 14.07.21 г. 9:11, Qu Wenruo wrote:
> Since v4.19, btrfs-progs has full write support to free space tree, the
> out-of-date warning in btrfs(5) has already confused some end user.
> 
> Update the content to avoid further confusion.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
