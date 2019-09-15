Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4774EB3144
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Sep 2019 19:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfIORyP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Sep 2019 13:54:15 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:36857 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728529AbfIORyP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Sep 2019 13:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=MIME-Version:Content-Type:In-Reply-To:References:Subject:Cc:To:
        From:Message-ID:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=h93H2bGKwTkH/M054UpGkXm+gvZkW92YuziGhjlq7u0=; b=3fXkBUfvln/TwsHLmcIB/2kfbc
        MtAUtAsoSmmYST4rPm3GrClnYSpPvooscFUE/CvU7KbB8fZIktc3rWN1Wrw7oeIdsZlzUI5r0HYDg
        Whoq9rgPVfmJapFWBg66GgvQb3MXZFWpsMWJJs1cBscIZZbF8nm5O1lbwdURaYDbXwLGVlsVzzZQ0
        S6YjoDpLOaM4F8zBA4GVVbL1uhDYVzKybuQoW3Owp3dQdu8dw3cc2IVpVD2GXmFn+DFiHa4lzb+A0
        SwoX/B9sQPg5f+meSdYZlavMCVlJAZ13/y4k8Y5EQzailknBI+dOO76ZZOHzIC4WBmU7+AqVvRc9W
        s7D0caug==;
Received: from [::1] (port=47848 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <general-zed@zedlx.com>)
        id 1i9Yit-001N0m-Jl; Sun, 15 Sep 2019 13:54:12 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Sun, 15 Sep 2019 13:54:07 -0400
Date:   Sun, 15 Sep 2019 13:54:07 -0400
Message-ID: <20190915135407.Horde.qqs07Bais-BPrjIVxyrrIfo@server53.web-hosting.com>
From:   General Zed <general-zed@zedlx.com>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <CAJCQCtQbRCdVOknOo6vusG+fQu1SB3=h8r=qDcZHUu+EFe480A@mail.gmail.com>
 <20190912173440.Horde.WmxNqLlw7nsFNa-Ux9TTgbz@server53.web-hosting.com>
 <CAJCQCtS8i5rTOYgEM2DFjoiZJBFsL6sgOGwp-1shMs859-r=qg@mail.gmail.com>
 <20190912185726.Horde.HMciH9Z16kV4fK10AfUeRA8@server53.web-hosting.com>
 <20190912235427.GE22121@hungrycats.org>
 <20190912202604.Horde.2Cvnicewbvpdb39q5eBASP7@server53.web-hosting.com>
 <20190913031242.GF22121@hungrycats.org>
 <20190913010552.Horde.cUL303XsYbqREB5g0iiCDKd@server53.web-hosting.com>
 <20190914005655.GH22121@hungrycats.org>
 <20190913215038.Horde.gsxNyK9aSRLm6Qsl5sUNhf0@server53.web-hosting.com>
 <20190914044219.GL22121@hungrycats.org>
In-Reply-To: <20190914044219.GL22121@hungrycats.org>
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


Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:

> On Fri, Sep 13, 2019 at 09:50:38PM -0400, General Zed wrote:
>>
>> Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
>>
>> > On Fri, Sep 13, 2019 at 01:05:52AM -0400, General Zed wrote:
>> > >
>> > > Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
>> > >
>> > > > On Thu, Sep 12, 2019 at 08:26:04PM -0400, General Zed wrote:
>> > > > >
>> > > > > Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
>> > > > >
>> > > > > > Don't forget you have to write new checksum and free  
>> space tree pages.
>> > > > > > In the worst case, you'll need about 1GB of new metadata pages
>> > > for each
>> > > > > > 128MB you defrag (though you get to delete 99.5% of them  
>> immediately
>> > > > > > after).
>> > > > >
>> > > > > Yes, here we are debating some worst-case scenaraio which  
>> is actually
>> > > > > imposible in practice due to various reasons.
>> > > >
>> > > > No, it's quite possible.  A log file written slowly on an active
>> > > > filesystem above a few TB will do that accidentally.  Every  
>> now and then
>> > > > I hit that case.  It can take several hours to do a logrotate  
>> on spinning
>> > > > arrays because of all the metadata fetches and updates associated with
>> > > > worst-case file delete.  Long enough to watch the delete happen, and
>> > > > even follow along in the source code.
>> > > >
>> > > > I guess if I did a proactive defrag every few hours, it might  
>> take less
>> > > > time to do the logrotate, but that would mean spreading out all the
>> > > > seeky IO load during the day instead of getting it all done at night.
>> > > > Logrotate does the same job as defrag in this case (replacing  
>> a file in
>> > > > thousands of fragments spread across the disk with a few  
>> large fragments
>> > > > close together), except logrotate gets better compression.
>> > > >
>> > > > To be more accurate, the example I gave above is the worst case you
>> > > > can expect from normal user workloads.  If I throw in some reflinks
>> > > > and snapshots, I can make it arbitrarily worse, until the entire disk
>> > > > is consumed by the metadata update of a single extent defrag.
>> > > >
>> > >
>> > > I can't believe I am considering this case.
>> > >
>> > > So, we have a 1TB log file "ultralog" split into 256 million 4  
>> KB extents
>> > > randomly over the entire disk. We have 512 GB free RAM and 2% free disk
>> > > space. The file needs to be defragmented.
>> > >
>> > > In order to do that, defrag needs to be able to copy-move  
>> multiple extents
>> > > in one batch, and update the metadata.
>> > >
>> > > The metadata has a total of at least 256 million entries, each  
>> of some size,
>> > > but each one should hold at least a pointer to the extent (8  
>> bytes) and a
>> > > checksum (8 bytes): In reality, it could be that there is a lot of other
>> > > data there per entry.
>> >
>> > It's about 48KB per 4K extent, plus a few hundred bytes on  
>> average for each
>> > reference.
>>
>> Sorry, could you be more clear there? An file fragment/extent that holds
>> file data can be any
>> size up to 128 MB. What metadata is there per every file fragment/extent?
>>
>> Because "48 KB per 4 K extent" ... cannot decode what you mean.
>
> An extent has 3 associated records in btrfs, not including its references.
> The first two exist while the extent exists, the third appears after it
> is removed.
>
> 	- extent tree:  location, size of extent, pointers to backref trees.
> 	Length is around 60 bytes plus the size of the backref pointer list.

Wait.. and where are the reflinks? Backrefs are there for going up the  
tree, but where are reflinks for going down the tree?

So, you are saying that backrefs are already in the extent tree (or  
reachable from it). I didn't know that, that information makes my  
defrag much simpler to implement and describe. Someone in this thread  
has previously mislead me to believe that backref information is not  
easily available.

>
> 	- csum tree:  location, 1 or more 4-byte csums packed in an array.
> 	Length of item is number of extent data blocks * 4 bytes plus a
> 	168-bit header (ish...csums from adjacent extents may be packed
> 	using a shared header)
>
> 	- free space tree:  location, size of free space.  This appears
> 	when the extent is deleted.  It may be merged with adjacent
> 	records.  Length is maybe 20 bytes?
>
> Each page contains a few hundred items, so if there are a few hundred
> unrelated extents between extents in the log file, each log file extent
> gets its own metadata page in each tree.

As far as I can understand it, the extents in the extent tree are  
indexed (keyed) by inode&offset. Therefore, no matter how many  
unrelated extents there are between (physical locations of data)  
extents in the log file, the log file extent tree entries will  
(generally speaking) be localized, because multiple extent entries  
(extent items) are bunched tohgether in one 16 KB metadata extent node.

>> Another question is: what is the average size of metadata extents?
>
> Metadata extents are all 16K.
>
>> > > The metadata is organized as a b-tree. Therefore, nearby nodes should
>> > > contain data of consecutive file extents.
>> >
>> > It's 48KB per item.
>>
>> What's the "item"?
>
> Items are the objects stored in the trees.  So one extent item, one csum
> item, and one free space tree item, all tied to the 4K extent from the
> log file.
>
>> > As you remove the original data extents, you will
>> > be touching a 16KB page in three trees for each extent that is removed:
>> > Free space tree, csum tree, and extent tree.  This happens after the
>> > merged extent is created.  It is part of the cleanup operation that
>> > gets rid of the original 4K extents.
>>
>> Ok, but how big are free space tree and csum tree?
>
> At least 12GB in the worst-case example.

The "worst case example" is when all file data extents are 4 KB in  
size, with a 4 KB hole between each two extents. Such example doesn't  
need to be considered because it is irrelevant.

But, if you were to consider it, you would quickly figure out that a  
good defrag solution would succeed in defragging this abomination of a  
filesystem, it is just that it would take some extra time to do it.

>> Also, when moving a file to defragment it, there should still be some
>> locality even in free space tree.
>
> It is only guaranteed in the defrag result, because the defrag result is
> the only thing that is necessarily physically contiguous.

In order not to lose sight:
This argument is related to "how big metadata update there needs to  
be" for some pathological cases. The worry is that the metadata update  
is going to be larger than the file data update. The word "update"  
here does NOT refer to in-place operations.

Any my answer is: we digressed so badly that we lost sight of the  
above original question.

And the answer to the original question is: there is no problem. Why?  
Because there is no better solution. Either you don't do defrag, or  
you have a nasty metadata update in some pathological cases. There is  
no magic wand there, no shortcut.

The good thing is that those pathological cases are irrelevent,  
because, if there was too much of them, btrfs wouldn't be able to  
function at all.

I mean, any file write operation could also modify all three btrfs  
trees. So what? It just works.
Even more, if free space is fragmented, a file append can turn into a  
nasty update to the free-space tree. So, there you go, the same  
problem can be found in everyday operation of btrfs.

>> And the csum tree, it should be ordered similar to free space tree, right?
>
> They are all ordered by extent physical address (same physical blocks,
> same metadata item key).
>
>> > Because the file was written very slowly on a big filesystem, the extents
>> > are scattered pessimally all over the virtual address space, not packed
>> > close together.  If there are a few hundred extent allocations between
>> > each log extent, then they will all occupy separate metadata pages.
>>
>> Ok, now you are talking about your pathological case. Let's consider it.
>>
>> Note that there is very little that can be in this case that you are
>> describing. In order to defrag such a file, either the defrag will take many
>> small steps and therefore it will be slow (because each step needs to
>> perform an update to the metadata), or the defrag can do it in one big step
>> and use a huge amount of RAM.
>>
>> So, the best thing to be done in this situation is to allow the user to
>> specify the amount of RAM that defrag is allowed to use, so that the user
>> decides which of the two (slow defrag or lots of RAM) he wants.
>>
>> There is no way around it. There is no better defrag than the one that has
>> ALL information at hand, that one will be the fastest and the best defrag.
>>
>> > When it is time to remove them, each of these pages must be updated.
>> > This can be hit in a number of places in btrfs, including overwrite
>> > and delete.
>> >
>> > There's also 60ish bytes per extent in any subvol trees the file
>> > actually appears in, but you do get locality in that one (the key is
>> > inode and offset, so nothing can get between them and space them apart).
>> > That's 12GB and change (you'll probably completely empty most of the
>> > updated subvol metadata pages, so we can expect maybe 5 pages to remain
>> > including root and interior nodes).  I haven't been unlucky enough to
>> > get a "natural" 12GB, but I got over 1GB a few times recently.
>>
>> The thing that I figured out (and I have already written it down in another
>> post) is that the defrag can CHOOSE AT WILL how large update to metadata it
>> wants to perform (within the limit of available RAM). The defrag can select,
>> by itself, the most efficient way to proceed while still honoring the
>> user-supplied limit on RAM.
>
> Yeah, it can update half the reflinks and pause for a commit, or similar.
> If there's a power failure then there will be a duplicate extent with some
> of the references to one copy and some to the other, but this is probably
> rare enough not to matter.

Exactly! That's the same that I was thinking.

>> > Reflinks can be used to multiply that 12GB arbitrarily--you only get
>> > locality if the reflinks are consecutive in (inode, offset) space,
>> > so if the reflinks are scattered across subvols or files, they won't
>> > share pages.
>>
>> OK.
>>
>> Yes, given a sufficiently pathological case, the defrag will take forever.
>> There is nothing unexpected there. I agree on that point. The defrag always
>> functions within certain prerequisites.
>>
>> > > The trick, in this case, is to select one part of "ultralog" which is
>> > > localized in the metadata, and defragment it. Repeating this step will
>> > > ultimately defragment the entire file.
>> > >
>> > > So, the defrag selects some part of metadata which is entirely  
>> a descendant
>> > > of some b-tree node not far from the bottom of b-tree. It  
>> selects it such
>> > > that the required update to the metadata is less than, let's  
>> say, 64 MB, and
>> > > simultaneously the affected "ultralog" file fragments total  
>> less han 512 MB
>> > > (therefore, less than 128 thousand metadata leaf entries, each  
>> pointing to a
>> > > 4 KB fragment). Then it finds all the file extents pointed to  
>> by that part
>> > > of metadata. They are consecutive (as file fragments), because we have
>> > > selected such part of metadata. Now the defrag can safely  
>> copy-move those
>> > > fragments to a new area and update the metadata.
>> > >
>> > > In order to quickly select that small part of metadata, the  
>> defrag needs a
>> > > metatdata cache that can hold somewhat more than 128 thousand localized
>> > > metadata leaf entries. That fits into 128 MB RAM definitely.
>> > >
>> > > Of course, there are many other small issues there, but this  
>> outlines the
>> > > general procedure.
>> > >
>> > > Problem solved?
>>
>> > Problem missed completely.  The forward reference updates were the only
>> > easy part.
>>
>> Oh, I'll reply in another mail, this one is getting too tireing.
>>
>>



