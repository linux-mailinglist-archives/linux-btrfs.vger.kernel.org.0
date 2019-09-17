Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79536B4541
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2019 03:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391373AbfIQBe6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Sep 2019 21:34:58 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:41146 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391353AbfIQBe6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Sep 2019 21:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=MIME-Version:Content-Type:In-Reply-To:References:Subject:Cc:To:
        From:Message-ID:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=FSfoXEFrJNfUTyIOeIY2/Y+y2uo/UxVYM0xIU12TMIc=; b=sspePzJyXG65nXZHg58oiqAOLk
        X0uEitP/TWR7u09YP+2rJ25Tf33kTYDRrzpYkha7cD6bTvN8y6UXWavluQIVclt2v3qMWytej+UKP
        uC/8Dmk1U6B6QbgP5qk+2/Ba3X2eRWTttikvIs8MpWQgKiymj+7qxG7BhhwJjhpQgOeJAWNEP8o8N
        f5nHupCEBwIDZHB5wJwMIN/MIEsmJGrdwyIXHUN7w2kBQn2jdgCgpJgeNMfFOk7f46UGLFl4H0nHk
        hsYU0dv5BUVQvCfHq+necCHYzHkIb2cPOWjrEHiTTAKXXjk4/Q+x0JOCym8Eb4JT5yaV/I5iz+JIx
        BVQY7/yg==;
Received: from [::1] (port=33530 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <general-zed@zedlx.com>)
        id 1iA2OJ-004373-UU; Mon, 16 Sep 2019 21:34:56 -0400
Received: from [95.178.242.132] ([95.178.242.132]) by
 server53.web-hosting.com (Horde Framework) with HTTPS; Mon, 16 Sep 2019
 21:34:51 -0400
Date:   Mon, 16 Sep 2019 21:34:51 -0400
Message-ID: <20190916213451.Horde.CVGC1tsP9Z8Q-7hBi7l1ymH@server53.web-hosting.com>
From:   General Zed <general-zed@zedlx.com>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <CAJCQCtS8i5rTOYgEM2DFjoiZJBFsL6sgOGwp-1shMs859-r=qg@mail.gmail.com>
 <20190912185726.Horde.HMciH9Z16kV4fK10AfUeRA8@server53.web-hosting.com>
 <20190912235427.GE22121@hungrycats.org>
 <20190912202604.Horde.2Cvnicewbvpdb39q5eBASP7@server53.web-hosting.com>
 <20190913031242.GF22121@hungrycats.org>
 <20190913010552.Horde.cUL303XsYbqREB5g0iiCDKd@server53.web-hosting.com>
 <20190914005655.GH22121@hungrycats.org>
 <20190913215038.Horde.gsxNyK9aSRLm6Qsl5sUNhf0@server53.web-hosting.com>
 <20190914044219.GL22121@hungrycats.org>
 <20190915135407.Horde.qqs07Bais-BPrjIVxyrrIfo@server53.web-hosting.com>
 <20190916225126.GB24379@hungrycats.org>
 <20190916210317.Horde.CLwHiAXP00_WIX7YMxFiew3@server53.web-hosting.com>
In-Reply-To: <20190916210317.Horde.CLwHiAXP00_WIX7YMxFiew3@server53.web-hosting.com>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server53.web-hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - zedlx.com
X-Get-Message-Sender-Via: server53.web-hosting.com: authenticated_id: zedlryqc/from_h
X-Authenticated-Sender: server53.web-hosting.com: general-zed@zedlx.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Quoting General Zed <general-zed@zedlx.com>:

> Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
>
>> On Sun, Sep 15, 2019 at 01:54:07PM -0400, General Zed wrote:
>>>
>>> Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
>>>
>>>> On Fri, Sep 13, 2019 at 09:50:38PM -0400, General Zed wrote:
>>>> >
>>>> > Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
>>>> >
>>>> > > On Fri, Sep 13, 2019 at 01:05:52AM -0400, General Zed wrote:
>>>> > > >
>>>> > > > Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
>>>> > > >
>>>> > > > > On Thu, Sep 12, 2019 at 08:26:04PM -0400, General Zed wrote:
>>>> > > > > >
>>>> > > > > > Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
>>>> > > > > >
>>>> > > > > > > Don't forget you have to write new checksum and free space
>>>> > tree pages.
>>>> > > > > > > In the worst case, you'll need about 1GB of new metadata pages
>>>> > > > for each
>>>> > > > > > > 128MB you defrag (though you get to delete 99.5% of them
>>>> > immediately
>>>> > > > > > > after).
>>>> > > > > >
>>>> > > > > > Yes, here we are debating some worst-case scenaraio which is
>>>> > actually
>>>> > > > > > imposible in practice due to various reasons.
>>>> > > > >
>>>> > > > > No, it's quite possible.  A log file written slowly on an active
>>>> > > > > filesystem above a few TB will do that accidentally.  Every
>>>> > now and then
>>>> > > > > I hit that case.  It can take several hours to do a logrotate
>>>> > on spinning
>>>> > > > > arrays because of all the metadata fetches and updates  
>>>> associated with
>>>> > > > > worst-case file delete.  Long enough to watch the delete  
>>>> happen, and
>>>> > > > > even follow along in the source code.
>>>> > > > >
>>>> > > > > I guess if I did a proactive defrag every few hours, it might
>>>> > take less
>>>> > > > > time to do the logrotate, but that would mean spreading  
>>>> out all the
>>>> > > > > seeky IO load during the day instead of getting it all  
>>>> done at night.
>>>> > > > > Logrotate does the same job as defrag in this case (replacing
>>>> > a file in
>>>> > > > > thousands of fragments spread across the disk with a few large
>>>> > fragments
>>>> > > > > close together), except logrotate gets better compression.
>>>> > > > >
>>>> > > > > To be more accurate, the example I gave above is the  
>>>> worst case you
>>>> > > > > can expect from normal user workloads.  If I throw in  
>>>> some reflinks
>>>> > > > > and snapshots, I can make it arbitrarily worse, until the  
>>>> entire disk
>>>> > > > > is consumed by the metadata update of a single extent defrag.
>>>> > > > >
>>>> > > >
>>>> > > > I can't believe I am considering this case.
>>>> > > >
>>>> > > > So, we have a 1TB log file "ultralog" split into 256 million 4
>>>> > KB extents
>>>> > > > randomly over the entire disk. We have 512 GB free RAM and  
>>>> 2% free disk
>>>> > > > space. The file needs to be defragmented.
>>>> > > >
>>>> > > > In order to do that, defrag needs to be able to copy-move
>>>> > multiple extents
>>>> > > > in one batch, and update the metadata.
>>>> > > >
>>>> > > > The metadata has a total of at least 256 million entries, each
>>>> > of some size,
>>>> > > > but each one should hold at least a pointer to the extent (8
>>>> > bytes) and a
>>>> > > > checksum (8 bytes): In reality, it could be that there is a  
>>>> lot of other
>>>> > > > data there per entry.
>>>> > >
>>>> > > It's about 48KB per 4K extent, plus a few hundred bytes on average
>>>> > for each
>>>> > > reference.
>>>> >
>>>> > Sorry, could you be more clear there? An file fragment/extent that holds
>>>> > file data can be any
>>>> > size up to 128 MB. What metadata is there per every file  
>>>> fragment/extent?
>>>> >
>>>> > Because "48 KB per 4 K extent" ... cannot decode what you mean.
>>>>
>>>> An extent has 3 associated records in btrfs, not including its references.
>>>> The first two exist while the extent exists, the third appears after it
>>>> is removed.
>>>>
>>>> 	- extent tree:  location, size of extent, pointers to backref trees.
>>>> 	Length is around 60 bytes plus the size of the backref pointer list.
>>>
>>> Wait.. and where are the reflinks? Backrefs are there for going up  
>>> the tree,
>>> but where are reflinks for going down the tree?
>>
>> Reflinks are the forward references--there is no other kind of forward
>> reference in btrfs (contrast with other filesystems which use one data
>> structure for single references and another for multiple references).
>>
>> There are two distinct objects with similar names:  extent data items,
>> and extent ref items.
>>
>> A file consists of an inode item followed by extent ref items (aka
>> reflinks) in a subvol tree keyed by (inode, offset) pairs.  Subvol tree
>> pages can be shared with other subvol trees to make snapshots.
>
> Ok, so a reflink contains a virtual address. Did I get that right?
>
> All extent ref items are reflinks which contain a 4 KB aligned  
> address because the extents have that same alignment. Did I get that  
> right?
>
> Virtual addresses are 8-bytes in size?
>
> I hope that virtual addresses are not wasteful of address space  
> (that is, many top bits in an 8 bit virtual address are all zero).
>
>> Extent data items are stored in a single tree (with other trees using
>> the same keys) that just lists which parts of the filesystem are occupied,
>> how long they are, and what data/metadata they contain.  Each extent
>> item contains a list of references to one of four kinds of object that
>> refers to the extent item (aka backrefs).  The free space tree is the
>> inverse of the extent data tree.
>
> Ok, so there is an "extent tree" keyed by virtual addresses. Items  
> there contain extent data.
>
> But, how are nodes in this extent tree addressed (how do you travel  
> from the parent to the child)? I guess by full virtual address, i.e.  
> by a reflink, but this reflink can point within-extent, meaning its  
> address is not 4 KB aligned.
>
> Or, an alternative explanation:
> each whole metadata extent is a single node. Each node is often  
> half-full to allow for various tree operations to be performed. Due  
> to there being many items per each node, there is additional CPU  
> processing effort required when updating a node.
>
>> Each extent ref item is a reference to an extent data item, but it
>> also contains all the information required to access the data.  For
>> normal read operations the extent data tree can be ignored (though
>> you still need to do a lookup in the csum tree to verify csums.
>
> So, for normal reads, the information in subvol tree is sufficient.
>
>>> So, you are saying that backrefs are already in the extent tree (or
>>> reachable from it). I didn't know that, that information makes my defrag
>>> much simpler to implement and describe. Someone in this thread has
>>> previously mislead me to believe that backref information is not easily
>>> available.
>>
>> The backref isn't a precise location--it just tells you which metadata
>> blocks are holding at least one reference to the extent.  Some CPU
>> and linear searching has to be done to resolve that fully to an (inode,
>> offset) pair in the subvol tree(s).  It's a tradeoff to make normal POSIX
>> go faster, because you don't need to update the extent tree again when
>> you do some operations on the forward ref side, even though they add or
>> remove references.  e.g. creating a snapshot does not change the backrefs
>> list on individual extents--it creates two roots sharing a subset of the
>> subvol trees' branches.
>
> This reads like a mayor fu**** to me.
>
> I don't get it. If a backref doesn't point to an exact item, than  
> CPU has to scan the entire 16 KB metadata extent to find the  
> matching reflink. However, this would imply that all the items in a  
> metadata extent are always valid (not stale from older versions of  
> metadata). This then implies that, when an item of a metadata extent  
> is updated, all the parents of all the items in the same extent have  
> to be updated. Now, that would be such a waste, wouldn't it?  
> Especially if the metadata extent is allowed to contain stale items.
>
> An alternative explanation: all the b-trees have 16 KB nodes, where  
> each node matches a metadata extent. Therefore, the entire node has  
> a single parent in a particular tree.
>
> This means all virtual addresses are always 4 K aligned,  
> furthermore, all virtual addresses that point to metadata extents  
> are 16 K aligned.
>
> 16 KB is a pretty big for a tree node. I wonder why was this size  
> selected vs. 4 KB nodes? But, it doesn't matter.
>
>>>> 	- csum tree:  location, 1 or more 4-byte csums packed in an array.
>>>> 	Length of item is number of extent data blocks * 4 bytes plus a
>>>> 	168-bit header (ish...csums from adjacent extents may be packed
>>>> 	using a shared header)
>>>>
>>>> 	- free space tree:  location, size of free space.  This appears
>>>> 	when the extent is deleted.  It may be merged with adjacent
>>>> 	records.  Length is maybe 20 bytes?
>>>>
>>>> Each page contains a few hundred items, so if there are a few hundred
>>>> unrelated extents between extents in the log file, each log file extent
>>>> gets its own metadata page in each tree.
>>>
>>> As far as I can understand it, the extents in the extent tree are indexed
>>> (keyed) by inode&offset. Therefore, no matter how many unrelated extents
>>> there are between (physical locations of data) extents in the log file, the
>>> log file extent tree entries will (generally speaking) be  
>>> localized, because
>>> multiple extent entries (extent items) are bunched tohgether in one 16 KB
>>> metadata extent node.
>>
>> No, extents in the extent tree are indexed by virtual address (roughly the
>> same as physical address over small scales, let's leave the device tree
>> out of it for now).  The subvol trees are organized the way you are
>> thinking of.
>
> So, I guess that the virtual-to-physical address translation tables  
> are always loaded in memory and that this translation is very fast?  
> And the translation in the opposite direction, too.
>
> Anyway, thanks for explaining this all to me, makes it all much more clear.

Taking into account the explanation that b-tree nodes are sized 16 KB,  
this is what my imagined defrag would do:

This defrag makes batched updates to metadata. A most common cases, a  
bathched update (with a single commit) will have the following  
properties:

- it moves many file data extents from one place to another. However,  
the update is mostly localized in space (for common fragmentation  
cases), meaning that only a low number of fragments per update will be  
significantly scattered. Therefore, updates to extent-tree are  
localized.

- the free space tree - mostly localized updates, for same reason as above

- the checksum tree - the same as above

- the subvol tree - a (potentially big) number of files is affected  
per update. In most cases of fragmentation, the dispersion of  
fragments will not be high. However, due to number of files, updating  
this tree looks like the most performance-troubling part of all. The  
problem is that while there is only a small dispersion per each file,  
when this gets multiplied by the number of files, it can get bad. Some  
dispersion in this tree is to be expected. The update size can  
effectively be limited by the size of changes to the subvol tree (in  
complex cases).

- the expected dispersion in the subvol tree can get better after  
multiple defrags, if the defrag is made to approximately order the  
files on disk according to their position in filesystem directory  
tree. So, the files of the same directory should be grouped together  
in disk sectors in order to speed up the future defrags.

So, as each b-tree node is 16 K, but I guess most nodes are only  
half-full, the average node size is 8 KB. If the defrag reserves 128  
MB for a metadata update computation, it could update 16000 (16  
thousand) metadata nodes per one commit. It would be interesting to  
try to predict what amount of file data, on average, is referred by  
such a 16000 nodes commit?

Ok, let's do some pure guessing. For a home user, with 256 GB root or  
home partition, I would guess the average will be well over 500 MB  
file data per commit. It depends on how long has it been since his  
last defrag. If it is a weekly or a daily defrag, then I guess well  
over 1 GB file data per commit.

And for a server, there are so many different kinds of servers, so  
I'll just skip the guessing.


