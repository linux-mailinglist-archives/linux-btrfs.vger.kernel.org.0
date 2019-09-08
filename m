Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB29EACB4B
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Sep 2019 09:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfIHHPg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Sep 2019 03:15:36 -0400
Received: from know-smtprelay-omd-6.server.virginmedia.net ([81.104.62.38]:48392
        "EHLO know-smtprelay-omd-6.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726844AbfIHHPf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 8 Sep 2019 03:15:35 -0400
Received: from phoenix.exfire ([86.12.75.74])
        by cmsmtp with ESMTP
        id 6rQ6ikjabzHXx6rQ6ix9RE; Sun, 08 Sep 2019 08:15:34 +0100
X-Originating-IP: [86.12.75.74]
X-Authenticated-User: 
X-Spam: 0
X-Authority: v=2.3 cv=B9mXLtlM c=1 sm=1 tr=0 a=RxXffCTTaIU9mOmmEQ6aGA==:117
 a=RxXffCTTaIU9mOmmEQ6aGA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=J70Eh1EUuV4A:10 a=VwQbUJbxAAAA:8 a=bgQfb_Kf-zc6SKpYNAIA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by phoenix.exfire (8.15.2/8.15.2) with ESMTP id x887Eda0014371;
        Sun, 8 Sep 2019 08:14:39 +0100
Subject: Re: Chasing IO errors. BTRFS: error (device dm-2) in
 btrfs_run_delayed_refs:2907: errno=-5 IO failure
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <fc2b166a-4466-4a5a-ee88-da5e57ee89b6@petezilla.co.uk>
 <CAJCQCtSWi+PUbOWXNwv0guCLRuSgZunWdvRBB4TKMG_X48jHFw@mail.gmail.com>
 <2433d4cb-e7f7-72c5-977b-02f51e9717b3@petezilla.co.uk>
 <e439aafe-8836-b761-3b72-b9215b463c09@gmx.com>
 <c593c2ef-044d-32e1-a75d-a2116a5b91a5@petezilla.co.uk>
 <a632bbef-974a-1ff5-fa10-300ce9a47b42@gmx.com>
From:   Pete <pete@petezilla.co.uk>
Message-ID: <0631cbba-bf58-db1b-b568-750d2f05e824@petezilla.co.uk>
Date:   Sun, 8 Sep 2019 08:14:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a632bbef-974a-1ff5-fa10-300ce9a47b42@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLLmx2xIt1NHgNWmp+9OweghyS/WmvLSx/rnRok8agv1mo52t8PpBRO7QDyqUr8nKuoXDWsh4xxtxz/x06Ntj49I+WcLQko583fZAcSsvuSxddN6M0q7
 aGcdoQXC3gA6OBSdT3mzBvhv1nGm2FOBoO+1L1FIVwtyVUcDG0gLTY5brMV2zpHJpnd+yR5dkI2u0prHctOjTUbc7jhTSEc9rmi20eveFE8GYVwCyWRzz7ud
 vfl/dkHOdHcwcxV7pR+15A==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/22/19 12:32 AM, Qu Wenruo wrote:

>>> Then I'd recommend to do regular rescue procedure:
>>> - Try that skip_bg patchset if possible
>>>   This provides the best salvage method so far, full subvolume
>>>   available, although needs out-of-tree patches.
>>>   https://patchwork.kernel.org/project/linux-btrfs/list/?series=130637
>>>
>>
>> I can give that a go, but not for a while.
>>
>> I seem to be able to read the file system as is, as it goes read only.
>> But perhaps 'seems' is the operative word.
> 
> As long as you can mount RO, it shouldn't be mostly OK for data salvage.
> 

Posting this for completeness, as this started just before I went away
for a while.

The filesystem was RO but there were failures copying affected files
meaning my copy from the RO file system was incomplete.  So I likely
_should_ have applied the patch suggested above, if that was my only
copy.  Instead I recovered from backups.

Thanks for your help.

Pete
