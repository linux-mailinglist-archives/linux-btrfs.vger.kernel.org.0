Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3005941C36D
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 13:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245049AbhI2L1g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 07:27:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54248 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244819AbhI2L1f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 07:27:35 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E6F9A2255C;
        Wed, 29 Sep 2021 11:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632914753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S9JnKl9XMZ0vhgzWuO+1ik/qkUVGS2gIikILISqFpDY=;
        b=L9fIAeS9GDKbZv8VA8tOVcXBOFE9wvljRhV5HiAX2TItjFz0RvKx7DoCTGC9AigUB32WQN
        vUL4zieJJYw8Y8eWJFxTC+Uavs3vBU3NbgjfQEhyLt9LZEUFU/IaH+jyVDm97b89TQS+Vd
        UVbdwBQ8EY09pBtck1YtUGt9bPzQHh0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1BB213FBD;
        Wed, 29 Sep 2021 11:25:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3gK/LEFNVGEmCgAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 29 Sep 2021 11:25:53 +0000
Subject: Re: [PATCH 1/2] btrfs-progs: Ignore path device during device scan
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20210928123730.393551-1-nborisov@suse.com>
 <50f82537-0ccc-701d-215a-f45c20c0827b@oracle.com>
 <9330f390-f561-7358-f932-46fd580f98e5@suse.com>
 <036be5f7-642b-60b4-f862-7541e65c0551@oracle.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <42ce59f6-4458-5cf9-351e-7fa81d62ebf5@suse.com>
Date:   Wed, 29 Sep 2021 14:25:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <036be5f7-642b-60b4-f862-7541e65c0551@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29.09.21 г. 14:13, Anand Jain wrote:
<snip>

>> flap means going up and down. The gist is that btrfs fi show would show
>> the latest device being scanned, which in the case of multipath device
>> could be any of the paths.
> 
>  Do you mean 'btrfs fi show' shows a device of the multi-path however,
>  'btrfs fi show -m' shows the correct multi-path device?

Yes, that's a problem purely in btrfs-progs, as the path devices are
opened exclusively for the purpose of multiapth.
> 
> <snip>
> 
