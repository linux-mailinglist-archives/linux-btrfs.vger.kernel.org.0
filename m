Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9F539566E
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 09:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhEaHod (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 03:44:33 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39704 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhEaHn7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 03:43:59 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D49532191F
        for <linux-btrfs@vger.kernel.org>; Mon, 31 May 2021 07:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622446937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YOKDhcemfI5nyg6uCcYekc50bGIf/4EUxNZRsLkJMWQ=;
        b=sYk5qQINBO+DPBlauGlmSTLiHfz84Bad8mjF2yxI/f9D/rM5RQxKey0fVMPAvjvihsRCeZ
        ZKXi+Pcjl2U1cfzHZ2DCSK2WGGUdhW9+K+exc/fQHkUe1zIP047sZeRrm5beDywFaQbBN8
        cam3S9ckD1sFECG7SZkDngI56oK5WHw=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 69D10118DD
        for <linux-btrfs@vger.kernel.org>; Mon, 31 May 2021 07:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622446937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YOKDhcemfI5nyg6uCcYekc50bGIf/4EUxNZRsLkJMWQ=;
        b=sYk5qQINBO+DPBlauGlmSTLiHfz84Bad8mjF2yxI/f9D/rM5RQxKey0fVMPAvjvihsRCeZ
        ZKXi+Pcjl2U1cfzHZ2DCSK2WGGUdhW9+K+exc/fQHkUe1zIP047sZeRrm5beDywFaQbBN8
        cam3S9ckD1sFECG7SZkDngI56oK5WHw=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id wZaJF1mTtGDZHgAALh3uQQ
        (envelope-from <nborisov@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 31 May 2021 07:42:17 +0000
Subject: Re: [PATCH] btrfs: Refactor error handling in btrfs_zero_range
To:     linux-btrfs@vger.kernel.org
References: <20210225125828.1601531-1-nborisov@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <a43a205f-4735-9b3c-40a6-6bcb067d544a@suse.com>
Date:   Mon, 31 May 2021 10:42:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210225125828.1601531-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Authentication-Results: imap.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.00
X-Spamd-Result: default: False [0.00 / 100.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_NONE(0.00)[];
         PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
         RCPT_COUNT_ONE(0.00)[1];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 25.02.21 г. 14:58, Nikolay Borisov wrote:
> The major complexity when it comes to error handling in btrfs_zero_range
> stems from the code executed under the 'reserve_space' label. Rather
> than it having an effect on the whole of btrfs_zero_range refactor it
> so that error handling specific to the functions called in this branch
> is contained only within the branch itself. This obviates the need for
> having the 'space_reserved' local flag since btrfs_free_reserved_data_space
> is called from the 2 error branches it's needed. Furthermore, this
> rids the code from the out label and enables converting most 'goto out'
> statements to simiple 'return ret' making the function easier to read.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Ping
