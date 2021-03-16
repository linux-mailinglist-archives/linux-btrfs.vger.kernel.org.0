Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F3433D1C7
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 11:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbhCPK1u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 06:27:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:43780 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234838AbhCPK1k (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 06:27:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0DD05AD74;
        Tue, 16 Mar 2021 10:27:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 833E2DA6E2; Tue, 16 Mar 2021 11:25:37 +0100 (CET)
Date:   Tue, 16 Mar 2021 11:25:37 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 01/15] btrfs: add sysfs interface for supported
 sectorsize
Message-ID: <20210316102537.GG7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210310090833.105015-1-wqu@suse.com>
 <20210310090833.105015-2-wqu@suse.com>
 <61c2ba18-c3de-a67f-046f-1f315500c8c8@oracle.com>
 <59a9ee34-1893-a642-2a00-8cc42ec7a31f@gmx.com>
 <20210315184414.GZ7604@twin.jikos.cz>
 <57e0fbcc-a8db-a821-5948-fb048f426dc8@gmx.com>
 <82e16fe9-cf79-fb5e-2863-d9f6cc73adbc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82e16fe9-cf79-fb5e-2863-d9f6cc73adbc@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 16, 2021 at 08:10:13AM +0800, Anand Jain wrote:
> 
> 
> On 16/03/2021 08:05, Qu Wenruo wrote:
> > 
> > 
> > On 2021/3/16 上午2:44, David Sterba wrote:
> >> On Mon, Mar 15, 2021 at 08:39:31PM +0800, Qu Wenruo wrote:
> >>>
> >>>
> >>> On 2021/3/15 下午7:59, Anand Jain wrote:
> >>>> On 10/03/2021 17:08, Qu Wenruo wrote:
> >>>>> Add extra sysfs interface features/supported_ro_sectorsize and
> >>>>> features/supported_rw_sectorsize to indicate subpage support.
> >>>>>
> >>>>> Currently for supported_rw_sectorsize all architectures only have 
> >>>>> their
> >>>>> PAGE_SIZE listed.
> >>>>>
> >>>>> While for supported_ro_sectorsize, for systems with 64K page size, 4K
> >>>>> sectorsize is also supported.
> >>>>>
> >>>>> This new sysfs interface would help mkfs.btrfs to do more accurate
> >>>>> warning.
> >>>>>
> >>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>>>> ---
> >>>>
> >>>> Changes looks good. Nit below...
> >>>> And maybe it is a good idea to wait for other comments before reroll.
> >>>>
> >>>>>    fs/btrfs/sysfs.c | 34 ++++++++++++++++++++++++++++++++++
> >>>>>    1 file changed, 34 insertions(+)
> >>>>>
> >>>>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> >>>>> index 6eb1c50fa98c..3ef419899472 100644
> >>>>> --- a/fs/btrfs/sysfs.c
> >>>>> +++ b/fs/btrfs/sysfs.c
> >>>>> @@ -360,11 +360,45 @@ static ssize_t
> >>>>> supported_rescue_options_show(struct kobject *kobj,
> >>>>>    BTRFS_ATTR(static_feature, supported_rescue_options,
> >>>>>           supported_rescue_options_show);
> >>>>> +static ssize_t supported_ro_sectorsize_show(struct kobject *kobj,
> >>>>> +                        struct kobj_attribute *a,
> >>>>> +                        char *buf)
> >>>>> +{
> >>>>> +    ssize_t ret = 0;
> >>>>> +    int i = 0;
> >>>>
> >>>>    Drop variable i, as ret can be used instead of 'i'.
> >>>>
> >>>>> +
> >>>>> +    /* For 64K page size, 4K sector size is supported */
> >>>>> +    if (PAGE_SIZE == SZ_64K) {
> >>>>> +        ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%u", SZ_4K);
> >>>>> +        i++;
> >>>>> +    }
> >>>>> +    /* Other than above subpage, only support PAGE_SIZE as sectorsize
> >>>>> yet */
> >>>>> +    ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%lu\n",
> >>>>
> >>>>> +             (i ? " " : ""), PAGE_SIZE);
> >>>>                             ^ret
> >>>>
> >>>>> +    return ret;
> >>>>> +}
> >>>>> +BTRFS_ATTR(static_feature, supported_ro_sectorsize,
> >>>>> +       supported_ro_sectorsize_show);
> >>>>> +
> >>>>> +static ssize_t supported_rw_sectorsize_show(struct kobject *kobj,
> >>>>> +                        struct kobj_attribute *a,
> >>>>> +                        char *buf)
> >>>>> +{
> >>>>> +    ssize_t ret = 0;
> >>>>> +
> >>>>> +    /* Only PAGE_SIZE as sectorsize is supported */
> >>>>> +    ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%lu\n", PAGE_SIZE);
> >>>>> +    return ret;
> >>>>> +}
> >>>>> +BTRFS_ATTR(static_feature, supported_rw_sectorsize,
> >>>>> +       supported_rw_sectorsize_show);
> >>>>
> >>>>    Why not merge supported_ro_sectorsize and supported_rw_sectorsize
> >>>>    and show both in two lines...
> >>>>    For example:
> >>>>      cat supported_sectorsizes
> >>>>      ro: 4096 65536
> >>>>      rw: 65536
> >>>
> >>> If merged, btrfs-progs needs to do line number check before doing string
> >>> matching.
> >>
> >> The sysfs files should do one value per file.
> >>
> >>> Although I doubt the usefulness for supported_ro_sectorsize, as the
> >>> window for RO support without RW support should not be that large.
> >>> (Current RW passes most generic test cases, and the remaining failures
> >>> are very limited)
> >>>
> >>> Thus I can merged them into supported_sectorsize, and only report
> >>> sectorsize we can do RW as supported.
> >>
> >> In that case one file with the list of supported values is a better
> >> option. The main point is to have full RW support, until then it's
> >> interesting only for developers and they know what to expect.
> >>
> > 
> > Indeed only full RW support makes sense.
> > 
>   Makes sense to me.
> 
> > BTW, any comment on the file name? If no problem I would just use
> > "supported_sectorsize" in next update.
> 
>   supported_sectorsizes (plural) is better IMO.

Yeah pluar is consistent with what we have now, eg. supported_checksums
