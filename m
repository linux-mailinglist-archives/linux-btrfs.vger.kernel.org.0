Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02593910B4
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 08:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbhEZG2q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 02:28:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:46564 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhEZG2p (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 02:28:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622010434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XqyLEsiFdoX/b1IfXoBK4BX16fpA0f2giQbnjHOooWE=;
        b=TBp/qOcVa4daCB2x4L/L4+Hhe8iDpmTEJ7LlDQ3zR5nBeTh/fD+UZmCLnrbSQPE2VL10+l
        jMeTwCOfLoWh1w+m/B0Fx5WZbxaCAE/lPtuzQD5g8g2ubjSzhtB1GBZzKyIRgGZDJ6hivc
        hgR55IItCaRYhOvG1pX++XA+xbHLLlw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 179D9B228;
        Wed, 26 May 2021 06:27:14 +0000 (UTC)
Subject: Re: BLAKE3 for Btrfs?
To:     Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Matthew Miller <mattdm@fedoraproject.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
References: <CAEg-Je-3pS3BCOv4xVoFeTRkH9ovs5RLn4OjqPWMoQnbHGA9RQ@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <afb9eba2-02c0-6b5c-8642-17b827c2a7cc@suse.com>
Date:   Wed, 26 May 2021 09:27:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAEg-Je-3pS3BCOv4xVoFeTRkH9ovs5RLn4OjqPWMoQnbHGA9RQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 26.05.21 г. 8:51, Neal Gompa wrote:
> I just read this article on BLAKE3 1.0 coming soon[1], and the
> performance of BLAKE3 looks extremely compelling. With the context of
> thinking about Btrfs authenticated hashes and fsverity[2], it seems
> like it would make sense to see if BLAKE3 can provide us roughly
> similar performance to xxhash or crc32. If so, that would make it
> highly attractive for a new default hash, too[3].


Especially in the context of security I'd say we shouldn't be quick to
jump on the bandwagon. Let the algorithm be ratified, let it simmer in
the public for a while to see if any weakness are found and then we can
consider adding it.
