Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110E543DDB9
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 11:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhJ1J3z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Oct 2021 05:29:55 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:47006 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229850AbhJ1J3y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Oct 2021 05:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1635413246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iChSsGCqzhpQTNjDdjxkMGlF5ZwYcIqWhF4MGhytEns=;
        b=JSZwn5Jpxx2MpAtCMVlC+NJMZ2NV21bWJ6Xcwid7Hv6F/EYiRTZlVVqqYLwlgbEwiubFvF
        kHjkCb6G7pm6gJJrPqsyu0sywximt9FJlytf8EIT+MW/Tcq0L3Ha4LAo2vgqHqFS4+JePH
        WxJcjd9fWzSCNzgfhUeesxGNPbAyZc4=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-21-lR1XN_-tMISMvohaMinfMw-1; Thu, 28 Oct 2021 11:27:25 +0200
X-MC-Unique: lR1XN_-tMISMvohaMinfMw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSFqg03hnEBI9LBygYqSPi87kGEc7pM8G8s4AqY4OMQ+fb8vwcFjstSbS+ut7YfyXHm2ACxQ4tyRnC0+LR7nPGFif8TXc76g5PuvmTCyMeY8LPPcPKSSBU3JpfHFbzZxmBrc1R/uluulV2wLcFL46lYTC8EwwOfbrXrZLm44JQD+HackmF/iUfmhTTU8P8f2q2CfN+ij9ul2TUjNOdPAC9Cv6msh43vF3XpUbCD+Be2oVKS/4X8T7mP83zeUYIM3tlB2H8qKsgjvzBiqXhCm/XBMmfX1+lWofXUhU+23n8BdDalJQ8xkr3SjDuYlcbaJmB8Nn5cuvSFIGgCf1QYckA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iChSsGCqzhpQTNjDdjxkMGlF5ZwYcIqWhF4MGhytEns=;
 b=RB7EOn83KqkJH6/x4NhypBwjooBYcqmVvcVtWq5O3Q+uhj5tl2GffaN6tFTy38pyB3m8DQSiR52xIs2Z0LDzOghksJGPj87NjeGD70b54JSLGmSivIYQHaRjkdzXV+phAjo2lPGKgHJrjCQ5U/A3NmnsqHeMc37Lu/Su+RPJro7WoYmz/5FeQmXfTks+IT73ErdBLoQXU09WRnNs+3kfbvStnMzEBGoMFocCxOhZl94HLmWxc5UkbgJnoshPPjXhutz9K3E2cnHzeMRlJ8JmYaHfhorloV1KCG//5+cigXkYhZgytfsUV8+7OJ3yOemE+eEtB+eayaa6YWRBpEG8aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DU2PR04MB8648.eurprd04.prod.outlook.com (2603:10a6:10:2df::21)
 by DU2PR04MB8742.eurprd04.prod.outlook.com (2603:10a6:10:2e0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 28 Oct
 2021 09:27:24 +0000
Received: from DU2PR04MB8648.eurprd04.prod.outlook.com
 ([fe80::7c78:3729:f82b:6802]) by DU2PR04MB8648.eurprd04.prod.outlook.com
 ([fe80::7c78:3729:f82b:6802%8]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 09:27:24 +0000
Date:   Thu, 28 Oct 2021 17:27:18 +0800
From:   Michael Chang <mchang@suse.com>
To:     The development of GNU GRUB <grub-devel@gnu.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fs/btrfs: Make extent item iteration to handle gaps
Message-ID: <20211028092718.GA32643@mazu>
References: <20211016014049.201556-1-wqu@suse.com>
 <3845c0be-6ed8-171e-67c2-92a6f80a60cd@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3845c0be-6ed8-171e-67c2-92a6f80a60cd@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HKAPR03CA0007.apcprd03.prod.outlook.com
 (2603:1096:203:c8::12) To DU2PR04MB8648.eurprd04.prod.outlook.com
 (2603:10a6:10:2df::21)
MIME-Version: 1.0
Received: from localhost (2001:b011:30d0:3ecc:6600:6aff:fe77:a7be) by HKAPR03CA0007.apcprd03.prod.outlook.com (2603:1096:203:c8::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend Transport; Thu, 28 Oct 2021 09:27:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36edee60-31bb-47c5-8bcc-08d999f5264b
X-MS-TrafficTypeDiagnostic: DU2PR04MB8742:
X-Microsoft-Antispam-PRVS: <DU2PR04MB874282F89C4D6AEEB40949E9AB869@DU2PR04MB8742.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wB/x9pXitpmQTcHEw0vxu0DwoWqiX1tZFcg/lLgTSZY+ot6fr7cMpAs2NCzok3J4+KhCp/Et3B3MQIWmS2E36YNlCKgtTK8x91E1tT+JIZ5evl5KiJxjOVjK+gAoSBGRAjakylVP3RbWdlT4q/j4YAvLTrjdEB5aRGeXJC6I/W5UCqgekrz3tt0vpObxA5yVzPGOIBpLa+dRBkxwny0M9+QSdb2Qc1DcXi0/yRcXB7Hrglx9JDP1pTegXmrMqToAv/de9Otu9oG9nfBmPAg0xB6gnYKZkomIM9+hXSYBNTzUL55TFaIl2dcGpjsKyhB5g45sSWiwSoTycwimAev8CjuItFfrdE04Hi1Gal8Cpsh/lt5ZkVMdQHozILw6JuW930xUrFMILY0Gk50uFiZGEGpGtHBq60w3ngvXi6GP+S29AOJUrAPh/NzRufksOojfsaSQWohvuI8Iy2weIdga4dtVp/GOdiCpSLuiSMP3udHLeBx5ie4WZwrGBU5PyF5P0oQQQnH5DZ/bjwYJcRiIq4xyZKrx0pV+KPFk6AeUkeQve2MVIAGYcV/tU9sOld7wuBQyPV9FpavNglF6uskoYuMQjfMYMR5lZibDC0tP7Glu2D8rNUa61GEd6MupmDqnwS5/X9jdDgFBKIUbr+ljv47mKR+vekc7X/5Ay3mffVLoMCZ3V/ry21eLGSx5o0J4TGU6iFMD0kFYOwXGotacU8AgwSj1cXuxsfEUPUcFbGA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8648.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6666004)(5660300002)(2906002)(83380400001)(6916009)(86362001)(33716001)(508600001)(1076003)(53546011)(4326008)(38100700002)(33656002)(66946007)(9686003)(66476007)(6496006)(8676002)(66556008)(966005)(8936002)(6486002)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8TBIOXCM6xwgfj5FLxo6abFCPtS0mA53loFQhVJhpZaeY/J8/zkgnl8YZ2KA?=
 =?us-ascii?Q?UnXS0yvU3pRcQQwugdDFeGQuDADLQnnwhINxYGIqxqHAiwhGTDnGJ2Df+Mq0?=
 =?us-ascii?Q?zOzcrEF9m+4wadKe1xvpdzOKp28WSFVs7QvRoWjLYBGS1dO5Tn6Ss+9r2Zfr?=
 =?us-ascii?Q?kNp+1KB05vD3GvmTZRo9GlkKwmBPvlpUVj8FFC9LYBidJosJ/6Fb3MyXkaj/?=
 =?us-ascii?Q?i+hgIMqeq4Qh4n7JPcakTxKwskX30pJjPJtILIevBGWcrd4VUgqrOrXWT9TB?=
 =?us-ascii?Q?aXPgwRYTfGZwsWPDlKH1JmQv5uog7hMAXMijdXTKVsBjT26KvvOAYmsdXxcA?=
 =?us-ascii?Q?UEv+GOjz/c1ZdiM6L3DGV0ukyRVg2O0CppslL5JYyxH5ZPtfMzz/JeNCDH6W?=
 =?us-ascii?Q?L7GaDxk8aRaDkAXTNZgsTwMSe4CfQF1rFgW2cXg62iOfAy3DmVSh3bdzDNpy?=
 =?us-ascii?Q?tq3A1/jpDNEoGsLup+Vc5B9PNT37PdKlfzTXU1sjpr0HmtoVADyBqfd9POkB?=
 =?us-ascii?Q?b0qclopudqjP1C8sAlR33Def6o+yKiP3Ur7I4t+bHPbSksjN8K1KstGo81tO?=
 =?us-ascii?Q?Rbkfwn8bYPvpNO4Ic8mZKjB+ikL3d7f46YxEbJRfto5WkQjrIr7hVoMVJspa?=
 =?us-ascii?Q?czURtTBDH00STX+DmDoYFu4ghcVXQxm6/O4GkCaYQVncpGJqvMsxOHzfXMDF?=
 =?us-ascii?Q?NNeovUfxuFQ6FESQpXJQRel9g7KczExPDg5LviA3gxs4k/BgTxnWqh7/Mqdn?=
 =?us-ascii?Q?DdxPxrw0xaOVSnNXzleBUoxgFyPzSXZviUOaudKLesKcVKEPIacRoUA8kZ7B?=
 =?us-ascii?Q?/zBxWf9k4Ni96hk4WR9w3Y6XHs0opE6Ypuu/mjqKypf0tFC5+SLiEdTgme1/?=
 =?us-ascii?Q?x5REWrF1rcCoWQkPrDR+1NI6cQi1vwsDYo6WYELDITXi/IU1pAakwbVPGxGA?=
 =?us-ascii?Q?MbL4kAp2s3FxY4Bc5srsYFSCOAI3VGe8yfxjUs/9SyNZMtjm3t28rNoVda2n?=
 =?us-ascii?Q?Su+u8pwoY5hl4rp26Ao7RNjNjzLzJ4kgFM5jTGeSOhkx6zPEfncZTlK/BYAP?=
 =?us-ascii?Q?Rn1eUsiWwjbYkv09ME9dw2tKRWTC6HA1PhJguJkiklNlcdlnrtC4cse/M/vf?=
 =?us-ascii?Q?e+K6+ctjoDCazDIitUUAar0PnpyvLuktGYFhBR5hIyu+p1zt4ekSIx/F2L6T?=
 =?us-ascii?Q?24FQUipRfvSz/4GwswR2pBhBo9QtvSjMcGMolh75AVZzqzQVdettyv+Mrc9y?=
 =?us-ascii?Q?cxzhmAXPDRfgt+GgHxT7va2eo2BRg4SB/yaaSAvQhIZokDZSDOJxIvYlpoHw?=
 =?us-ascii?Q?I84vyt+IVZ2SZHlTKxiYPJX8x8FgIhVAtskFeGxUheOnQpoBe2MNfjZpf5aO?=
 =?us-ascii?Q?BP8d7x8J9ryIGAcFaHDxaNZU/0hzNLe2wBNZmyGAIdZ+aD4W8rl7zlBW5jU4?=
 =?us-ascii?Q?XPskGII6LKLqdQ83yvxGOzN3UlcTLS+9G2q8RqBkdyXF+9IqzPmfEDYhjBEo?=
 =?us-ascii?Q?cJYAxls2U2HK9vbYV1SjFaCDD4PTY58n0eRbxQUamLsj5ufLRCgrVrlJu93P?=
 =?us-ascii?Q?nhUWGoedjBRO5jQmU6fy4XAaUO/b9aui5NWLaDNSDak4riErCst5uzCglHKY?=
 =?us-ascii?Q?QRbq8h56UQL5rBHNR2qqc6U=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36edee60-31bb-47c5-8bcc-08d999f5264b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8648.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 09:27:24.0866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OOHZKjkczvRzmR47FPi85W4nHh5TMCVgXeExILMRov2qDdpnQ2HglzvAyhe/rXN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8742
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 28, 2021 at 03:36:10PM +0800, The development of GNU GRUB wrote:
> Gentle ping?
> 
> Without this patch, the new mkfs.btrfs NO_HOLES feature would break any
> kernel/initramfs with hole in it.
> 
> And considering the modification is already small, I believe this patch is
> definitely worthy as a bug fix.

+1

This does worth more attention as booting would have been blocked.

> 
> Thanks,
> Qu
> 
> On 2021/10/16 09:40, Qu Wenruo wrote:
> > [BUG]
> > Grub btrfs implementation can't handle two very basic btrfs file
> > layouts:
> > 
> > 1. Mixed inline/regualr extents
> >     # mkfs.btrfs -f test.img
> >     # mount test.img /mnt/btrfs
> >     # xfs_io -f -c "pwrite 0 1k" -c "sync" -c "falloc 0 4k" \
> > 	       -c "pwrite 4k 4k" /mnt/btrfs/file
> >     # umount /mnt/btrfs
> >     # ./grub-fstest ./grub-fstest --debug=btrfs ~/test.img hex "/file"
> > 
> >     Such mixed inline/regular extents case is not recommended layout,
> >     but all existing tools and kernel can handle it without problem
> > 
> > 2. NO_HOLES feature
> >     # mkfs.btrfs -f test.img -O no_holes
> >     # mount test.img /mnt/btrfs
> >     # xfs_io -f -c "pwrite 0 4k" -c "pwrite 8k 4k" /mnt/btrfs/file
> >     # umount /mnt/btrfs
> >     # ./grub-fstest ./grub-fstest --debug=btrfs ~/test.img hex "/file"
> > 
> >     NO_HOLES feature is going to be the default mkfs feature in the incoming
> >     v5.15 release, and kernel has support for it since v4.0.
> > 
> > [CAUSE]
> > The way GRUB btrfs code iterates through file extents relies on no gap
> > between extents.
> > 
> > If any gap is hit, then grub btrfs will error out, without any proper
> > reason to help debug the bug.
> > 
> > This is a bad assumption, since a long long time ago btrfs has a new
> > feature called NO_HOLES to allow btrfs to skip the padding hole extent
> > to reduce metadata usage.
> > 
> > The NO_HOLES feature is already stable since kernel v4.0 and is going to
> > be the default mkfs feature in the incoming v5.15 btrfs-progs release.
> > 
> > [FIX]
> > When there is a extent gap, instead of error out, just try next item.
> > 
> > This is still not ideal, as kernel/progs/U-boot all do the iteration
> > item by item, not relying on the file offset continuity.
> > 
> > But it will be way more time consuming to correct the whole behavior
> > than starting from scratch to build a proper designed btrfs module for GRUB.
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> >   grub-core/fs/btrfs.c | 33 ++++++++++++++++++++++++++++++---
> >   1 file changed, 30 insertions(+), 3 deletions(-)
> > 
> > diff --git a/grub-core/fs/btrfs.c b/grub-core/fs/btrfs.c
> > index 63203034dfc6..4fbcbec7524a 100644
> > --- a/grub-core/fs/btrfs.c
> > +++ b/grub-core/fs/btrfs.c
> > @@ -1443,6 +1443,7 @@ grub_btrfs_extent_read (struct grub_btrfs_data *data,
> >         grub_size_t csize;
> >         grub_err_t err;
> >         grub_off_t extoff;
> > +      struct grub_btrfs_leaf_descriptor desc;
> >         if (!data->extent || data->extstart > pos || data->extino != ino
> >   	  || data->exttree != tree || data->extend <= pos)
> >   	{
> > @@ -1455,7 +1456,7 @@ grub_btrfs_extent_read (struct grub_btrfs_data *data,
> >   	  key_in.type = GRUB_BTRFS_ITEM_TYPE_EXTENT_ITEM;
> >   	  key_in.offset = grub_cpu_to_le64 (pos);
> >   	  err = lower_bound (data, &key_in, &key_out, tree,
> > -			     &elemaddr, &elemsize, NULL, 0);
> > +			     &elemaddr, &elemsize, &desc, 0);
> >   	  if (err)
> >   	    return -1;
> >   	  if (key_out.object_id != ino
> > @@ -1494,10 +1495,36 @@ grub_btrfs_extent_read (struct grub_btrfs_data *data,
> >   			PRIxGRUB_UINT64_T "\n",
> >   			grub_le_to_cpu64 (key_out.offset),
> >   			grub_le_to_cpu64 (data->extent->size));
> > +	  /*
> > +	   * The way of extent item iteration is pretty bad, it completely
> > +	   * requires all extents are contiguous, which is not ensured.
> > +	   *
> > +	   * Features like NO_HOLE and mixed inline/regular extents can cause
> > +	   * gaps between file extent items.
> > +	   *
> > +	   * The correct way is to follow kernel/U-boot to iterate item by
> > +	   * item, without any assumption on the file offset continuity.
> > +	   *
> > +	   * Here we just manually skip to next item and re-do the verification.
> > +	   *
> > +	   * TODO: Rework the whole extent item iteration code, if not the
> > +	   * whole btrfs implementation.
> > +	   */
> >   	  if (data->extend <= pos)
> >   	    {
> > -	      grub_error (GRUB_ERR_BAD_FS, "extent not found");
> > -	      return -1;
> > +	      err = next(data, &desc, &elemaddr, &elemsize, &key_out);
> > +	      if (err < 0)
> > +		return -1;
> > +	      /* No next item for the inode, we hit the end */
> > +	      if (err == 0 || key_out.object_id != ino ||
> > +		  key_out.type != GRUB_BTRFS_ITEM_TYPE_EXTENT_ITEM)
> > +		      return pos - pos0;
> > +
> > +	      csize = grub_le_to_cpu64(key_out.offset) - pos;
> > +	      buf += csize;
> > +	      pos += csize;
> > +	      len -= csize;

Does it make sense to add some sort of range check here to safegard len
from being underflow ? My justfication is that csize value is read out
from disk so can be anything wild presumably.

Thanks,
Michael


> > +	      continue;
> >   	    }
> >   	}
> >         csize = data->extend - pos;
> > 
> 
> 
> _______________________________________________
> Grub-devel mailing list
> Grub-devel@gnu.org
> https://lists.gnu.org/mailman/listinfo/grub-devel

