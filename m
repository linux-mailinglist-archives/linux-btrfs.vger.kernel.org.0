Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6346C3B5E4E
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 14:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhF1Mqa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 08:46:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33048 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbhF1MqP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 08:46:15 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 20D7E22134;
        Mon, 28 Jun 2021 12:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624884229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ikm2TMI4Y4xDL3boa3rvCcwQvv97U4djsLciwJhltR4=;
        b=JT+NZTvq06bg/E0mpl9Bjg7cNni+MHJXUeDX7F+tnz+UxsVPD9wnMrCYizyTwrPAeZWTDD
        rS/3myjmKyCjHx9/h3NwwoCm6Y1yb54IqLsTtTjvuzwlmbgpn8pMz9lyRCEX2qFyQOJjkd
        qCZ3b+SF1bzXDXoNsSlqcGVpZFcmEy0=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 7C1A911906;
        Mon, 28 Jun 2021 12:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624884229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ikm2TMI4Y4xDL3boa3rvCcwQvv97U4djsLciwJhltR4=;
        b=JT+NZTvq06bg/E0mpl9Bjg7cNni+MHJXUeDX7F+tnz+UxsVPD9wnMrCYizyTwrPAeZWTDD
        rS/3myjmKyCjHx9/h3NwwoCm6Y1yb54IqLsTtTjvuzwlmbgpn8pMz9lyRCEX2qFyQOJjkd
        qCZ3b+SF1bzXDXoNsSlqcGVpZFcmEy0=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id JEVkGwTE2WBAUAAALh3uQQ
        (envelope-from <nborisov@suse.com>); Mon, 28 Jun 2021 12:43:48 +0000
Subject: Re: [PATCH] btrfs: remove unneeded variable: "ret"
To:     Qu Wenruo <wqu@suse.com>, dsterba@suse.cz,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "13145886936@163.com" <13145886936@163.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        gushengxian <gushengxian@yulong.com>
References: <20210628083050.5302-1-13145886936@163.com>
 <ee06042f-da1a-9137-dda3-b8f14bf1b79a@gmx.com>
 <DM6PR04MB7081A02339DB3ACC72F86261E7039@DM6PR04MB7081.namprd04.prod.outlook.com>
 <PH0PR04MB7416F1BC157F848540DF37389B039@PH0PR04MB7416.namprd04.prod.outlook.com>
 <e73fd408-d5c3-0e17-b3f4-e12f2c105bc0@gmx.com>
 <DM6PR04MB70814C2126868BE1DE1DDC19E7039@DM6PR04MB7081.namprd04.prod.outlook.com>
 <20210628120435.GC2610@twin.jikos.cz>
 <ce9083c7-ed1c-1248-484b-3b8650734f52@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <04cb5e3c-f9e8-e615-eab7-847e05694605@suse.com>
Date:   Mon, 28 Jun 2021 15:43:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ce9083c7-ed1c-1248-484b-3b8650734f52@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

<snip>

> 
> If this is from some guy with years experience, I would definitely bark
> at him, but this is one really looks like a newbie, thus it's more or
> less acceptable.

I beg to differ, if we want to have quality code we should be imposing
standards and shouldn't be doing exception just because someone is a
newbie. SO even if the patch is good per-se, because removing the ret is
fine, missing comprehensible rationale of why this is the case
constitutes a patch which falls short of said standards. In this case
feedback should be given and if the person doesn't take a note and
improve on his subsequent posting they should be ignored as this is
actively wasting everyone's time.


> 
> Thanks,
> Qu
<snip>
