Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57015523C25
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 May 2022 20:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346021AbiEKSBS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 May 2022 14:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345992AbiEKSBQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 May 2022 14:01:16 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 11 May 2022 11:01:13 PDT
Received: from libero.it (smtp-33.italiaonline.it [213.209.10.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8584C4FC5F
        for <linux-btrfs@vger.kernel.org>; Wed, 11 May 2022 11:01:12 -0700 (PDT)
Received: from [192.168.1.27] ([78.12.14.90])
        by smtp-33.iol.local with ESMTPA
        id oqd5npMvHtMz4oqd5n7EVB; Wed, 11 May 2022 20:00:08 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1652292008; bh=VdShixegbtXeUU2Zn4mVCL5DrvBXVQNiTGLFRYacw9Q=;
        h=From;
        b=ZMvKsAMJbak8RHNMDVMAK61g8tduwmvIUp1vlQERojUOdf7HMmWMSTWfD/dvTJPAv
         vgPGMcu9YK1UTwN4thivPYC9zsTXI8+Gzapkhokk1Y0kqfA3fjV5eoaCZzn/FYL8Tu
         9FI+DG3FjCDdAsgvUTAx4csGrD0minjX8TSh+m1WEuAiinuGxlY6YBoTpkV4ouWXnf
         cFzhGXQuWWaT5BRxbz7MAbTnspXC5CWsiyDJsGEPJus4DgNpjQ6gZFS8oSsi7Dmmp4
         1NdbcroekE3rsDJd6hYaYkyTLdl3VKXszp3LKceB7I4lxoOZ68yPHKeimp78Al84ao
         MuMK1axhonnlw==
X-CNFS-Analysis: v=2.4 cv=RvwAkAqK c=1 sm=1 tr=0 ts=627bf9a8 cx=a_exe
 a=tzWkov1jpxwUGlXVT4HyzQ==:117 a=tzWkov1jpxwUGlXVT4HyzQ==:17
 a=IkcTkHD0fZMA:10 a=hw2TasknAAAA:8 a=RLTRqU1dAdJ7KQOaySoA:9 a=QEXdDO2ut3YA:10
 a=MzwtZN9ZPDPljpYX1quu:22
Message-ID: <6e182895-9998-cf39-04e4-9542d79fc81d@libero.it>
Date:   Wed, 11 May 2022 20:00:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Reply-To: kreijack@inwind.it
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAEzrpqfYJDPdxxrw9TMFdF9GacYKMwc8=yFB6wt3=TMDt6Bung@mail.gmail.com>
 <20220510164448.GI12542@merlins.org> <20220510211507.GJ12542@merlins.org>
 <CAEzrpqe41JYFKE2tZFjgZ4V_YqO+K8m4nzF=R3Sti6hgv5snuQ@mail.gmail.com>
 <20220511000815.GK12542@merlins.org>
 <CAEzrpqcPdf8kNjywtGY-OKDAm-87o+1QDh0qX+0mOSV3D4WEqQ@mail.gmail.com>
 <20220511014827.GL12542@merlins.org>
 <CAEzrpqfzXn0sZNVDud4UfysxvF4mgbq_a_ToJioDFz2wE-d3Rw@mail.gmail.com>
 <20220511150319.GM29107@merlins.org>
 <CAEzrpqcT0fObDa8XFWtvzeqCKom42t5o+xE9atmFjWyHCHmb=g@mail.gmail.com>
 <20220511160009.GN12542@merlins.org>
 <CAEzrpqdO4FX0A1b9xYycJQuMsvzUegSLcze4hpkMOD9dn2F-pQ@mail.gmail.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <CAEzrpqdO4FX0A1b9xYycJQuMsvzUegSLcze4hpkMOD9dn2F-pQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFsXdT2dQXINecmdA20Y+GoczNrlF5Qe6px7XW1FSbNAtrnCHTUqcrFCAqnYPKvF87E6zPMye7lRNJ7vscWOJp9ZDb/+pUsPMxDtx8byOI+s1SnIyM6j
 tmejyNtvB4FhNL1Pn7W9AKq0N8NAcEU2EVfUw4dQRQzqCnU4CmKFH6kMYT/8TfNyqGBbQKq0irlVV6rtU2Pv3uasMa78n7t1/TBY+32+6WGtygVHyQ2IHdF1
 ldmGXCL5EunukV82myaBjw==
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/05/2022 18.05, Josef Bacik wrote:
> On Wed, May 11, 2022 at 12:00 PM Marc MERLIN <marc@merlins.org> wrote:
>>
>> On Wed, May 11, 2022 at 11:21:37AM -0400, Josef Bacik wrote:
[...]

Hi Joseph, Marc,

I looked back in the thread but I was unable to find if it was discussed.
Even if the size of the FS is quite big, I am wondering if does make sense
that Marc send to Josef the metadata of the filesystem, to speed up the
recover.

I am sure that btrfs-image was considered but then discarded (due to a risk
of leaking of sensible information ? or may be the image would be too big ?);

It would be interested to know the reasons; may be that even if btrfs-image
doesn't fit this particular case in the current form, it can be extended
to handle a case like the Marc one..

BR
-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
