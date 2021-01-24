Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E277301E9B
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jan 2021 21:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbhAXUGG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Jan 2021 15:06:06 -0500
Received: from smtp-33.italiaonline.it ([213.209.10.33]:41388 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726103AbhAXUGF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Jan 2021 15:06:05 -0500
Received: from venice.bhome ([94.37.172.193])
        by smtp-33.iol.local with ESMTPA
        id 3ldSlExHh11DD3ldSlnaBF; Sun, 24 Jan 2021 21:05:23 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1611518723; bh=N1LmADQ2vefsOHzsEDJqPVy95jZFYngDCgh3RsKHqhI=;
        h=From;
        b=jSzTWIKdjrtaWZKJzK7Nxldt/siy4yLwzM2VdweJVcFJOndpysR/MzxamKTPKz11V
         KMO1yFSSZFyRDbdjvvTDetix0Wt7PPJYIksipxKw2FDuRArxMJUPEkTcxD/SlCYM5N
         SfU5bN/ljBunXL0AKdf3Ftba2EzroDnVNXS/J9067Dtx9wgEZfCGfZSUsuTd93ppfs
         0r+J5ELhuL2igzp0o4sRyBsTCD93cNFUxzf/a5aTOn5csaxJZBVdfFMPkj1AzLq1Bs
         BTUOLPBmQAJyZCqtyOLVH0sUuKj/5/6+TKtcnw43cLeImCq+RptJ6b8A3Mj7GqCzPv
         x7KRL9QLHXKIQ==
X-CNFS-Analysis: v=2.4 cv=ba6u7MDB c=1 sm=1 tr=0 ts=600dd303 cx=a_exe
 a=z1y4hvBwYU35dpVEhKc0WA==:117 a=z1y4hvBwYU35dpVEhKc0WA==:17
 a=IkcTkHD0fZMA:10 a=5LBUgWogq-e1LdEdfLQA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [RFC][PATCH V5] btrfs: preferred_metadata: preferred device for
 metadata
To:     Graham Cobb <g.btrfs@cobb.uk.net>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20210117185435.36263-1-kreijack@libero.it>
 <30cd0359-e649-dcc7-e373-4dd778fbf70b@toxicpanda.com>
 <765cec4e-b989-081b-2ad7-e2d1c9cf7f55@libero.it>
 <20210121185400.GH28049@hungrycats.org>
 <89ee4ab9-64cd-b093-92d2-02eee4997250@inwind.it>
 <20210122224253.GI28049@hungrycats.org>
 <7b73eb0f-1b59-e6dd-5420-ef2d31a9fd62@cobb.uk.net>
 <20210123172118.GJ28049@hungrycats.org>
 <24522e9a-8cfb-73ab-2332-c7e0c6b9677c@cobb.uk.net>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <133c5436-ad39-2c92-d789-5be6529f81ba@inwind.it>
Date:   Sun, 24 Jan 2021 21:05:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <24522e9a-8cfb-73ab-2332-c7e0c6b9677c@cobb.uk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMULX0YvHoUgrtzESuRdJ+vAMOORq5FINlLtRJjo/sLGCZB4sXKlAh9Yvfh9Uv+j2QrNJnsRC1t+6yLdx36eqnc1XTwRiM/F/yJfm3QcrljHWIomrxMj
 DMUuLvDLLNOGzYJCQb6byliXNnxujHR/q8g4zqOfqiHfq/MFrzMIjjK0kIgchs4nokPkxnaFpTamsPs9bhZb+S7DhqvRWJgpZaaGef9FAHmTirxN8EuER8mV
 n9j8KAFhpqxapX4gcnx/g46C3tXTJcTzuSTvmO/NRIRirlAJ6O0HaPk35xBTEBh+TDIpP9NDdmgRZqB+tpZEgw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/23/21 6:44 PM, Graham Cobb wrote:
[...]
> I gave a few very simple examples, but I can think of many more cases
> where a disk may contain files which users might be able to access if
> the disk was mounted (maybe the disk has subvols used by many different
> systems but UIDs are not coordinated, or ...).  And, of course, if they
> can open a FD during the brief time it is mounted, they can stop it
> being unmounted again.
> 
> No. If I have chosen to mount just a subvol, it is because I don't want
> to mount the whole disk.

I agree with Graham, if we have to mount the root subvolume, it means
that the api is not so good.
Moreover, as explained also by you, the xattr are "exposed" to the risk
of be copied by a simple rsync -X (or cp --preserve=all ...)

BR
G.Baroncelli


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
