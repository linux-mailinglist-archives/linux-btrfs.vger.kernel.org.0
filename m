Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BCC40389B
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 13:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347184AbhIHLSa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 07:18:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39626 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346911AbhIHLS2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Sep 2021 07:18:28 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4C1D7222A4;
        Wed,  8 Sep 2021 11:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631099840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CySILisy47iDGJzQeaPSnY6olNBxj8JbDe42hLOcIdE=;
        b=eV2yZB3P79fSgDd/2JCNsd5q9Gk49k6vdI52SE6CyrktKrY8hzMfULs6gIKNXAvAVm9k4B
        zkBTN/otwc1BWradAFCk+NROrHU8xU9IEAJ+ipMI81k0EmyUCvGO3wuqDmSqizhw931vSU
        f0g5PbvBN4+avGxIJfj9yQbnMFI/uzg=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 14AAD13A73;
        Wed,  8 Sep 2021 11:17:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id M4sSAsCbOGGeAQAAGKfGzw
        (envelope-from <nborisov@suse.com>); Wed, 08 Sep 2021 11:17:20 +0000
Subject: Re: [PATCH 1/2] btrfs-progs: fi show: Print missing device for a
 mounted file system
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20210902100643.1075385-1-nborisov@suse.com>
 <20210907135041.GO3379@twin.jikos.cz>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <f31fb924-847a-8b54-3da6-707914135f05@suse.com>
Date:   Wed, 8 Sep 2021 14:17:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210907135041.GO3379@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7.09.21 г. 16:50, David Sterba wrote:
> devid    2 size 0 used 0 MISSING (last: /dev/loop1)


unfortunately that 'last:' is a bit cryptic, OTOH 'last seen as' sounds
a bit verbose. So I'd rather leave it as :

devid    2 size 0 used 0 path /dev/foo MISSING


In case we don't have a path for the device then the output would be :
devid    2 size 0 used 0 path  MISSING

I think that's simple enough.
