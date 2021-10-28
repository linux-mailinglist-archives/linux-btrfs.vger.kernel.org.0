Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CB943DD92
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 11:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhJ1JUX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Oct 2021 05:20:23 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51112 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhJ1JUW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Oct 2021 05:20:22 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1605521965;
        Thu, 28 Oct 2021 09:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635412675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2nwjrMJaLPLwolomJQlbq8enN6s5nVOPqsWK/uB9/g0=;
        b=p1OqQQVAF9Aw2H+SzAJybPl3uyeWExlGT3/0jwvgWaGRvzaK4uOZGA8RJIAbvXSWvKPqfq
        VkQucYcXXtbscLhJBD6ajoaGEEshiON4NHlL0RCZDKqX7tBRM0NR/EK0ckjpRGT8rK5DtC
        6EuWs2zUN96ApJWafZTkvqfJZWmgKDY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3C7513A69;
        Thu, 28 Oct 2021 09:17:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X+sJMcJqemGJWQAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 28 Oct 2021 09:17:54 +0000
Subject: Re: [PATCH] btrfs: Test proper interaction between skip_balance and
 paused balance
To:     fdmanana@gmail.com
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20211027135754.20101-1-nborisov@suse.com>
 <CAL3q7H66tOAu0qANiwimWcDZwhgMKQpO46qz+uR1FaF61Y8A0g@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <6f63dd3a-982f-6875-2e47-a091f8d8d96a@suse.com>
Date:   Thu, 28 Oct 2021 12:17:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H66tOAu0qANiwimWcDZwhgMKQpO46qz+uR1FaF61Y8A0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 28.10.21 г. 12:01, Filipe Manana wrote:
> On Wed, Oct 27, 2021 at 10:25 PM Nikolay Borisov <nborisov@suse.com> wrote:

<snip>

>> +if [[ ! -e /sys/fs/btrfs/$uuid/exclusive_operation ]]; then
>> +       _notrun "Requires btrfs exclusive operation support"
>> +fi
> 
> Why is it required to have the sysfs export file for the exclusive operations?
> The test doesn't use the file at all, and exclusive operations exist
> for many years, unlike the sysfs file which is recent.

Because the report mentioned the following error message being printed:

ERROR: unable to start device add, another exclusive operation 'balance'
in progress

And this comes from check_running_fs_exclop which got added as part of
the sysfs interface for exclusive ops.

> 

<snip>
