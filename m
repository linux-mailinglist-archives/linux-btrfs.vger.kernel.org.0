Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325423D8F53
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 15:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbhG1Nn6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 09:43:58 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:43046 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhG1Nn5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 09:43:57 -0400
X-Greylist: delayed 72593 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Jul 2021 09:43:57 EDT
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 56C309C360; Wed, 28 Jul 2021 14:43:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1627479835;
        bh=AVprTXs7DyGHj0L7AmX18qLo2Z3rK1/x2Gl7dXunk0c=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=P78icvf1LC1b3lK8Aazp7RxJK63O+aoNb27kYWo6Razi5LEgwkJsv2oFOz9g2QJm+
         uQABMy38OU1lTe4doxgxN3PviWxte1wly4H2+3Vuoy4d6SIzOKaKi3DaqTz1cdEasX
         U5tzo9O3chmA82NIZkc+KvMkVdJzo2heuYu7/aImhTvPG5gpSsEsVFfLKLhSDp1oDN
         khCzi58165JAVXEq+pRvCB99Z4EL641OjhZCcBxse3lTAcoXMIC4ClGbBjVGupHPuJ
         B/FwoCn7DSCRnSNfA+5w0zzH1+PayzZynNyf/BCzLw+2HwW9BC9EpsQhFVHSNQtnm/
         Ujvb/LaC/UuFQ==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-3.3 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id F3F339B846;
        Wed, 28 Jul 2021 14:43:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1627479833;
        bh=AVprTXs7DyGHj0L7AmX18qLo2Z3rK1/x2Gl7dXunk0c=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=Z6Jkm+JubTCKlQzFQC7kdv34buXMMFdGTRl0xbnIQMBu2D9WNo/T0dKFwZBvSpVzb
         CsXLqPq+mjMzbHKiqUUUasWfG5vRSLoEUQTZ2g5VYI8AH/CQAV4spRcLI+CmussRPT
         Wy0S7XH2GWbrFldyF9CvDJRZ5BAyxN8rUmSogjUu4ZXu5zgr5U9GuPhsu8yE+GMgsa
         c6INNSNPs7vrmGj7TyKDdD23JAr75chB8Xq/3wkaLa2OOAm6H78bETe/IJEbIikb3y
         Vu0QtVHihqTk8gdAjHsyMJzV4SRkQuSaJh4M4uM+URDtzrsDWVKl2d2T6EHUjqwZK2
         GefGpOz9uCYjA==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id A5D6027556C;
        Wed, 28 Jul 2021 14:43:52 +0100 (BST)
From:   g.btrfs@cobb.uk.net
To:     NeilBrown <neilb@suse.de>, Wang Yugui <wangyugui@e16-tech.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <20210728125819.6E52.409509F4@e16-tech.com>
 <20210728140431.D704.409509F4@e16-tech.com>
 <162745567084.21659.16797059962461187633@noble.neil.brown.name>
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
Message-ID: <2cb6455c-7b9f-9ac3-fd9d-9121eb1aa109@cobb.uk.net>
Date:   Wed, 28 Jul 2021 14:43:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <162745567084.21659.16797059962461187633@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/07/2021 08:01, NeilBrown wrote:
> On Wed, 28 Jul 2021, Wang Yugui wrote:
>> Hi,
>>
>> This patchset works well in 5.14-rc3.
> 
> Thanks for testing.
> 
>>
>> 1, fixed dummy inode(255, BTRFS_FIRST_FREE_OBJECTID - 1 )  is changed to
>> dynamic dummy inode(18446744073709551358, or 18446744073709551359, ...)
> 
> The BTRFS_FIRST_FREE_OBJECTID-1 was a just a hack, I never wanted it to
> be permanent.
> The new number is ULONG_MAX - subvol_id (where subvol_id starts at 257 I
> think).
> This is a bit less of a hack.  It is an easily available number that is
> fairly unique.
> 
>>
>> 2, btrfs subvol mount info is shown in /proc/mounts, even if nfsd/nfs is
>> not used.
>> /dev/sdc                btrfs   94G  3.5M   93G   1% /mnt/test
>> /dev/sdc                btrfs   94G  3.5M   93G   1% /mnt/test/sub1
>> /dev/sdc                btrfs   94G  3.5M   93G   1% /mnt/test/sub2
>>
>> This is a visiual feature change for btrfs user.
> 
> Hopefully it is an improvement.  But it is certainly a change that needs
> to be carefully considered.

Would this change the behaviour of findmnt? I have several scripts that
depend on findmnt to select btrfs filesystems. Just to take a couple of
examples (using the example shown above): my scripts would depend on
'findmnt --target /mnt/test/sub1 -o target' providing /mnt/test, not the
subvolume; and another script would depend on 'findmnt -t btrfs
--mountpoint /mnt/test/sub1' providing no output as the directory is not
an /etc/fstab mount point for a btrfs filesystem.

Maybe findmnt isn't affected? Or maybe the change is worth making
anyway? But it needs to be carefully considered if it breaks existing
user interfaces.
