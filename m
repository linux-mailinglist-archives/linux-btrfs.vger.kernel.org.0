Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF9A5461B7
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 11:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348688AbiFJJU7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jun 2022 05:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348606AbiFJJS6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jun 2022 05:18:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9048A2FB40E
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 02:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654852625;
        bh=5WYEtFbdVGsfxTqNjdG0AZvTheZxJXQ7HtIk9aKq2Po=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=QLGsa1H7JLdlgDV+bH00KyBHEdXUv3a2AM/o0y+EhXFf+VPpqUZBclkxeE9iy1xJC
         tV2lnO1lV7dT5iQ4i1OTX5KqIKeNiujuL9/oW/Y2E0T/YFYXBg2q9dg0RPcK3AEY+3
         ilIIaJAFBGv7CNkw+z8inA+jpxNAepba/ehOtYSE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mwfai-1noGDF4ABe-00y9DI; Fri, 10
 Jun 2022 11:17:05 +0200
Message-ID: <2d623799-53ca-7c20-0433-c455683c5e83@gmx.com>
Date:   Fri, 10 Jun 2022 17:17:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org
References: <6bd882fd0562b8b18600629f7d0504f98c560dcf.1654792073.git.johannes.thumshirn@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: add tracepoints for ordered extents
In-Reply-To: <6bd882fd0562b8b18600629f7d0504f98c560dcf.1654792073.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RXLqlRxYQhT6KzIRf462BXoXOXziBS82FhSKx5+s3kqz4Q6VJkR
 cT3qd+ejl9lFMH0nMJIYjOetIiIshpdlymaEuJV70+MZmFK0rvwebkYkFqwwjKI3Tn+KWkF
 J9BVjImCisHVEoxoOd93RsNJ7/8dbl37/Pjc+QlVftqQ6bIN/HxukiMOzoT6gtSWnDl35P3
 uv97OmnzjMQWofftz70uw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MVavWQVps4Q=:sRDXEd30o5OmytbKaPJJpZ
 lhEOwp1b9WsarsfeB1dzQqyAQsb/AgI7b0cWJdLeyQ/UAdfErOf3pA4uBURUjVnuETRl1LWFi
 Pj+CWCjGvetL/msQLwGCfBGKAOFFP7EwnskUl+smrZkPmRzuMBkASBJQT6qYp/rSMuHoQw2J0
 TqPi9qSOXokq0nFEBH9lFt8dJP7WnVVJMfsxylmrDErQ0Yx/ZgoY0RZ4PfuNsKZ4JaANyaKHZ
 ExG9HhMiG9Uh/oC2YeGSqXdBheIeYR28/w1HZzQUcrsdRaflH8cOODKATokCL8mmY4RQg4vaM
 TyrTRnmAIhbgCGZ7tD4wqw9dbLM/BaUttoQyG7xRKBYi4YgAWhfOjXR84yqmgsa7aSkG2NddL
 h0WI2RZFqnvlhDwK7PjiNRT2ZcP6QYO1Ytj1z5+2jGV0pImvWRGE3KONz0Fy1UQrHeOeMFVn3
 pl+XerLehX395UrhoILbrPbU8MUO1EFgZYSY796FE9IHS47k1PnLPy6OTAakBDuijDxsrB5o9
 HWejft7tYxKcKhVKMosBlV47r+BjQVECwvW6it8cpWa3uJ0ras/hd3QbSF9dmJDOvdCOhpOFQ
 /2iV70BOGsSHxJrIaz/SKgL5EkOmlD5YVY5410SL+nZiKh1HbPtqTpduq8A6CeYq0EvzENY55
 OlTb9uGphvF93LxsChGuN2AO6ZXt4nB17uBxmj4xq3FldLSatYbEDSnwgh4vgCcPgtVx30mNG
 OMIFNzfnTlRdzMmSsSU9Ht4jIS8eP5TBNmUefTR3PuZ4mgWSTGyDV3JI+Zm2I8fCbRN0ID8uz
 hy7n6eJFT5CMrCPNuWbtZHmgAHU6u/czQx6oQ1zIB1oIw6LPE82QVSRcaPeWcGWIwzU0kXvsi
 A6/QasThonOajjuOuM17gltf9wVf78yC4z+3NUTUVTxjohrTRBl4HmjuFvJkxoQy73ZgA4QVT
 +FHAb9Gx6O3SQDij0gSIzetd5Emht3HBchs5LnNcPpbul7nejsQ5Za4+7REGl677taprl8WWo
 dJXePaQLuC4Bye6wpn/JS+DiTNcgk4YQMTU1qpC6FhEvo75BDalYuzmaEdKXfQG2+tsCnr36F
 FlIyL7rsVLDf5MeqIe1jqq3rSgI6Uw0jOg57DxmiCR1AvL82gYywHN/0Q==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/10 00:28, Johannes Thumshirn wrote:
> When debugging a reference counting issue with ordered extents, I've fou=
nd
> we're lacking a lot of tracepoint coverage in the ordered-extent code.
>
> Close these gaps by adding tracepoints after every refcount_inc() in the
> ordered-extent code.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/ordered-data.c      | 19 +++++++++--
>   include/trace/events/btrfs.h | 64 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 80 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index dc88d2b3721f..41b3bc44c92b 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -401,6 +401,7 @@ void btrfs_mark_ordered_io_finished(struct btrfs_ino=
de *inode,
>   			set_bit(BTRFS_ORDERED_IO_DONE, &entry->flags);
>   			cond_wake_up(&entry->wait);
>   			refcount_inc(&entry->refs);
> +			trace_btrfs_ordered_extent_mark_finished(inode, entry);
>   			spin_unlock_irqrestore(&tree->lock, flags);
>   			btrfs_init_work(&entry->work, finish_func, NULL, NULL);
>   			btrfs_queue_work(wq, &entry->work);
> @@ -473,6 +474,7 @@ bool btrfs_dec_test_ordered_pending(struct btrfs_ino=
de *inode,
>   	if (finished && cached && entry) {
>   		*cached =3D entry;
>   		refcount_inc(&entry->refs);
> +		trace_btrfs_ordered_extent_dec_test_pending(inode, entry);
>   	}
>   	spin_unlock_irqrestore(&tree->lock, flags);
>   	return finished;
> @@ -807,8 +809,10 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_e=
xtent(struct btrfs_inode *ino
>   	entry =3D rb_entry(node, struct btrfs_ordered_extent, rb_node);
>   	if (!in_range(file_offset, entry->file_offset, entry->num_bytes))
>   		entry =3D NULL;
> -	if (entry)
> +	if (entry) {
>   		refcount_inc(&entry->refs);
> +		trace_btrfs_ordered_extent_lookup(inode, entry);
> +	}
>   out:
>   	spin_unlock_irqrestore(&tree->lock, flags);
>   	return entry;
> @@ -848,8 +852,10 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_r=
ange(
>   			break;
>   	}
>   out:
> -	if (entry)
> +	if (entry) {
>   		refcount_inc(&entry->refs);
> +		trace_btrfs_ordered_extent_lookup_range(inode, entry);
> +	}
>   	spin_unlock_irq(&tree->lock);
>   	return entry;
>   }
> @@ -878,6 +884,7 @@ void btrfs_get_ordered_extents_for_logging(struct bt=
rfs_inode *inode,
>   		ASSERT(list_empty(&ordered->log_list));
>   		list_add_tail(&ordered->log_list, list);
>   		refcount_inc(&ordered->refs);
> +		trace_btrfs_ordered_extent_lookup_for_logging(inode, ordered);
>   	}
>   	spin_unlock_irq(&tree->lock);
>   }
> @@ -901,6 +908,7 @@ btrfs_lookup_first_ordered_extent(struct btrfs_inode=
 *inode, u64 file_offset)
>
>   	entry =3D rb_entry(node, struct btrfs_ordered_extent, rb_node);
>   	refcount_inc(&entry->refs);
> +	trace_btrfs_ordered_extent_lookup_first(inode, entry);
>   out:
>   	spin_unlock_irq(&tree->lock);
>   	return entry;
> @@ -975,8 +983,11 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ord=
ered_range(
>   	/* No ordered extent in the range */
>   	entry =3D NULL;
>   out:
> -	if (entry)
> +	if (entry) {
>   		refcount_inc(&entry->refs);
> +		trace_btrfs_ordered_extent_lookup_first_range(inode, entry);
> +	}
> +
>   	spin_unlock_irq(&tree->lock);
>   	return entry;
>   }
> @@ -1055,6 +1066,8 @@ int btrfs_split_ordered_extent(struct btrfs_ordere=
d_extent *ordered, u64 pre,
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>   	int ret =3D 0;
>
> +	trace_btrfs_ordered_extent_split(BTRFS_I(inode), ordered);

I guess this doesn't have all the info for this split event?
Like pre/post values?

Although we will call clone_ordered_extent() which will call
btrfs_add_ordered_extent() and trigger the event for add.

It still doesn't really show the pre/post values directly.

Is there better way to just add extra members for the existing trace
event class?
If not, I guess that's all what we can do right now...

Thanks,
Qu


> +
>   	spin_lock_irq(&tree->lock);
>   	/* Remove from tree once */
>   	node =3D &ordered->rb_node;
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 29fa8ea2cc0f..73df80d462dc 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -598,6 +598,70 @@ DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_e=
xtent_put,
>   	TP_ARGS(inode, ordered)
>   );
>
> +DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_lookup,
> +
> +	     TP_PROTO(const struct btrfs_inode *inode,
> +		      const struct btrfs_ordered_extent *ordered),
> +
> +	     TP_ARGS(inode, ordered)
> +);
> +
> +DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_lookup_range,
> +
> +	     TP_PROTO(const struct btrfs_inode *inode,
> +		      const struct btrfs_ordered_extent *ordered),
> +
> +	     TP_ARGS(inode, ordered)
> +);
> +
> +DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_lookup_first_r=
ange,
> +
> +	     TP_PROTO(const struct btrfs_inode *inode,
> +		      const struct btrfs_ordered_extent *ordered),
> +
> +	     TP_ARGS(inode, ordered)
> +);
> +
> +DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_lookup_for_log=
ging,
> +
> +	     TP_PROTO(const struct btrfs_inode *inode,
> +		      const struct btrfs_ordered_extent *ordered),
> +
> +	     TP_ARGS(inode, ordered)
> +);
> +
> +DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_lookup_first,
> +
> +	     TP_PROTO(const struct btrfs_inode *inode,
> +		      const struct btrfs_ordered_extent *ordered),
> +
> +	     TP_ARGS(inode, ordered)
> +);
> +
> +DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_split,
> +
> +	     TP_PROTO(const struct btrfs_inode *inode,
> +		      const struct btrfs_ordered_extent *ordered),
> +
> +	     TP_ARGS(inode, ordered)
> +);
> +
> +DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_dec_test_pendi=
ng,
> +
> +	     TP_PROTO(const struct btrfs_inode *inode,
> +		      const struct btrfs_ordered_extent *ordered),
> +
> +	     TP_ARGS(inode, ordered)
> +);
> +
> +DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_mark_finished,
> +
> +	     TP_PROTO(const struct btrfs_inode *inode,
> +		      const struct btrfs_ordered_extent *ordered),
> +
> +	     TP_ARGS(inode, ordered)
> +);
> +
>   DECLARE_EVENT_CLASS(btrfs__writepage,
>
>   	TP_PROTO(const struct page *page, const struct inode *inode,
